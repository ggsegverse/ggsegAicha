# Create the AICHA subcortical atlas for ggseg
#
# AICHA parcellates the subcortex alongside the cortex, but the subcortical
# parcels ship as a labelled FSL-MNI152 volume with no anatomical context. As
# with the other MNI152 subcortical atlases in the ggsegverse, they are
# embedded into the fsaverage5 aseg with prepare_subcortical_mni152(), which
# registers them through the fixed mni152.register.dat transform, replaces the
# lumped aseg structures they subdivide, and returns a merged volume plus
# colour table for the subcortical pipeline. aseg_context() then demotes the
# surrounding brain to grey.
#
# The 40 parcels (ids 345-384, 20 per hemisphere) cover amygdala, caudate,
# pallidum, putamen and thalamus. The cortical half of AICHA is built
# separately in make_atlas.R.
#
# Source: https://github.com/anniegbryant/subcortex_visualization
#   (atlas_info/MNI152NLin6Asym/AICHA_subcortex)
# Reference: Joliot M, Jobard G, Naveau M, Delcroix N, Petit L, Zago L,
#   Crivello F, Mellet E, Mazoyer B, Tzourio-Mazoyer N (2015).
#   Journal of Neuroscience Methods 254:46-59.
#   DOI: 10.1016/j.jneumeth.2015.07.013
#
# Requires: ggseg.extra, ggseg.formats, FreeSurfer 7.4.1 with fsaverage5.
#
# Run with: Rscript data-raw/make_subcortical.R

library(ggseg.extra)
library(ggseg.formats)

future::plan(future::sequential)
progressr::handlers("cli")
progressr::handlers(global = TRUE)

fs_home <- Sys.getenv("FREESURFER_HOME", "/Applications/freesurfer/7.4.1")
Sys.setenv(FREESURFER_HOME = fs_home)
Sys.setenv(SUBJECTS_DIR = file.path(fs_home, "subjects"))

data_raw <- here::here("data-raw")
source_dir <- file.path(data_raw, "source")
volume <- file.path(source_dir, "AICHA_subcortex.nii.gz")
stopifnot("AICHA_subcortex.nii.gz not found" = file.exists(volume))

# AICHA names its parcels Structure-N-hemi, numbered within each structure.
# One hue per structure with the numbered parcels spread across shades of it
# keeps a structure recognisable as one thing, and keeps the two sides of a
# parcel the same colour.
structure_colours <- function(structure) {
  family <- sub("-[0-9]+$", "", structure)
  families <- sort(unique(family))
  hues <- grDevices::hcl.colors(length(families), palette = "Dark 3")
  names(hues) <- families

  colours <- character(length(structure))
  for (fam in families) {
    members <- sort(unique(structure[family == fam]))
    base <- grDevices::rgb2hsv(grDevices::col2rgb(hues[[fam]]))
    n <- length(members)
    shades <- if (n == 1L) {
      hues[[fam]]
    } else {
      grDevices::hsv(
        h = base[1],
        s = seq(
          max(0.25, base[2] - 0.30),
          min(1, base[2] + 0.15),
          length.out = n
        ),
        v = seq(
          min(1, base[3] + 0.25),
          max(0.35, base[3] - 0.20),
          length.out = n
        )
      )
    }
    colours[family == fam] <- shades[match(structure[family == fam], members)]
  }
  colours
}

read_aicha_lut <- function() {
  lookup <- utils::read.csv(
    file.path(source_dir, "AICHA_subcortex_lookup.csv"),
    header = FALSE,
    col.names = c("idx", "name"),
    fileEncoding = "UTF-8-BOM"
  )

  hemi <- ifelse(grepl("-lh$", lookup$name), "Left", "Right")
  if (!all(grepl("-(lh|rh)$", lookup$name))) {
    cli::cli_abort(
      "Every AICHA parcel name must end in {.val -lh} or {.val -rh}."
    )
  }
  structure <- sub("-[lr]h$", "", lookup$name)

  rgb <- grDevices::col2rgb(structure_colours(structure))

  data.frame(
    idx = as.integer(lookup$idx),
    label = paste(gsub("-", "_", structure), hemi, sep = "_"),
    R = as.integer(rgb[1, ]),
    G = as.integer(rgb[2, ]),
    B = as.integer(rgb[3, ]),
    A = 0L,
    stringsAsFactors = FALSE
  )
}

# geom_brain() paints rows in order, so the last one lands on top. Sorting by
# structure with the two sides adjacent keeps a parcel at the same depth as its
# contralateral twin, and the grey silhouette leads because it is the
# background the rest sits on and the only geometry present in every view.
draw_order <- function(atlas) {
  drawn <- atlas_geom(atlas)$label
  is_silhouette <- grepl("^cortex", drawn)
  by_structure <- function(x) {
    x[order(
      toupper(sub("_(Left|Right)$", "", x)),
      toupper(x),
      method = "radix"
    )]
  }
  atlas_structure_reorder(
    atlas,
    c(by_structure(drawn[is_silhouette]), by_structure(drawn[!is_silhouette]))
  )
}

cli::cli_h1("AICHA subcortical")

# Wiped rather than reused: contours left over from an earlier slab layout are
# re-read by the pipeline and land in the atlas with no matching view.
work_dir <- file.path(data_raw, "subcortical")
unlink(work_dir, recursive = TRUE)
dir.create(work_dir, showWarnings = FALSE, recursive = TRUE)

lut <- read_aicha_lut()

merged <- prepare_subcortical_mni152(
  input_volume = volume,
  labels = lut$idx,
  lut = lut,
  output_file = file.path(work_dir, "aicha_sub_in_aseg.nii.gz")
)

slabs <- subcortical_slabs(
  merged$volume,
  labels = lut$idx,
  coronal = 2,
  axial = 2,
  pad = 2
)

raw <- create_subcortical_from_volume(
  input_volume = merged,
  atlas_name = "aicha_sub",
  output_dir = work_dir,
  slabs = slabs,
  skip_existing = FALSE,
  cleanup = FALSE
)

# Post-creation, so retuning any of it is seconds rather than a rebuild. The
# parcels are grown a little to survive at plotting size; the silhouette is
# not, since dilating it closes the sulci. Simplify before smoothing, or the
# dropped vertices put the voxel staircase back.
aicha_sub <- raw |>
  aseg_context(focus = paste(lut$label, collapse = "|"), match_on = "label") |>
  atlas_view_gather() |>
  atlas_dilate(0.6, exclude = "^cortex") |>
  atlas_simplify(keep = 0.2, labels = "^cortex") |>
  atlas_simplify(keep = 0.25, exclude = "^cortex") |>
  atlas_smooth(smoothness = 0.4) |>
  draw_order()

cli::cli_alert_success(
  "{length(atlas_labels(aicha_sub))} structures in \\
   {length(atlas_views(aicha_sub))} views"
)

sysdata_path <- here::here("R", "sysdata.rda")
if (file.exists(sysdata_path)) {
  load(sysdata_path)
}
.aicha_sub <- aicha_sub

usethis::use_data(
  .aicha,
  .aicha_sub,
  internal = TRUE,
  overwrite = TRUE,
  compress = "xz"
)
