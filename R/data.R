#' AICHA Atlas (Atlas of Intrinsic Connectivity of Homotopic Areas)
#'
#' Brain atlas for the AICHA cortical parcellation with 342 regions.
#' The original volumetric atlas in MNI space was projected to fsaverage
#' using the CBIG lab's registration fusion. Contains both 2D polygon
#' geometry for [ggseg::geom_brain()] and 3D vertex indices for
#' [ggseg3d::ggseg3d()].
#'
#' @family ggseg_atlases
#' @family cortical_atlases
#'
#' @references Joliot M, Jobard G, Naveau M, Delcroix N, Petit L, Zago L,
#'   ... & Tzourio-Mazoyer N (2015). AICHA: An atlas of intrinsic
#'   connectivity of homotopic areas. *Journal of Neuroscience Methods*,
#'   254, 46-59.
#'   \doi{10.1016/j.jneumeth.2015.07.013}
#'
#' @return A [ggseg.formats::ggseg_atlas] object (cortical).
#' @import ggseg.formats
#' @export
#' @examples
#' aicha()
#' \dontrun{plot(aicha())}
aicha <- function() .aicha


#' AICHA Subcortical Atlas
#'
#' Subcortical half of the AICHA parcellation, with 20 parcels per
#' hemisphere covering amygdala, caudate, pallidum, putamen and thalamus.
#' Parcels are numbered within each structure, as AICHA names them. Drawn in
#' four views, two coronal and two axial, with the surrounding brain in grey
#' for anatomical context. Contains 2D polygon geometry for
#' [ggseg::geom_brain()] and 3D mesh data for [ggseg3d::ggseg3d()].
#'
#' The published subcortical volume was embedded in the fsaverage5 `aseg`
#' through the fixed MNI152 registration, so the parcels are drawn in
#' anatomical context rather than floating. Colour follows the structure: one
#' hue per structure, with its numbered parcels in shades of that hue.
#'
#' For the cortical half of AICHA see [aicha()].
#'
#' @family ggseg_atlases
#' @family subcortical_atlases
#'
#' @references Joliot M, Jobard G, Naveau M, Delcroix N, Petit L, Zago L,
#'   ... & Tzourio-Mazoyer N (2015). AICHA: An atlas of intrinsic
#'   connectivity of homotopic areas. *Journal of Neuroscience Methods*,
#'   254, 46-59.
#'   \doi{10.1016/j.jneumeth.2015.07.013}
#'
#' @return A [ggseg.formats::ggseg_atlas] object (subcortical).
#' @export
#' @examples
#' aicha_sub()
#' \dontrun{plot(aicha_sub())}
aicha_sub <- function() .aicha_sub
