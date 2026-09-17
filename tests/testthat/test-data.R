describe("aicha atlas", {
  it("is a ggseg_atlas", {
    expect_s3_class(aicha(), "ggseg_atlas")
    expect_s3_class(aicha(), "cortical_atlas")
  })

  it("is valid", {
    expect_true(ggseg.formats::is_ggseg_atlas(aicha()))
  })

  it("renders with ggseg", {
    skip_if_not_installed("ggseg")
    skip_if_not_installed("vdiffr")
    vdiffr::expect_doppelganger(
      "aicha-2d",
      ggseg::brain_test_plot(aicha())
    )
  })

  it("renders with ggseg3d", {
    skip_if_not_installed("ggseg3d")
    skip_if_not_installed("ggseg.meshes")
    p <- ggseg3d::ggseg3d(atlas = aicha())
    expect_s3_class(p, c("plotly", "htmlwidget"))
  })
})

describe("aicha_sub atlas", {
  it("is a subcortical ggseg_atlas", {
    expect_s3_class(aicha_sub(), "ggseg_atlas")
    expect_s3_class(aicha_sub(), "subcortical_atlas")
    expect_true(ggseg.formats::is_ggseg_atlas(aicha_sub()))
  })

  it("has 20 parcels per hemisphere", {
    core <- aicha_sub()$core
    expect_equal(nrow(core), 40)
    expect_equal(as.integer(table(core$hemi)[c("left", "right")]), c(20L, 20L))
  })

  it("covers the five subcortical structures", {
    labels <- aicha_sub()$core$label
    structures <- unique(sub("_[0-9]+_(Left|Right)$", "", labels))
    expect_setequal(
      structures,
      c("Amygdala", "Caudate", "Pallidum", "Putamen", "Thalamus")
    )
  })

  it("has 2D polygon geometry in four views", {
    expect_true(ggseg.formats::is_atlas_polygon(aicha_sub()))
    expect_length(ggseg.formats::atlas_views(aicha_sub()), 4)
  })

  it("has 3D meshes for every label", {
    meshes <- ggseg.formats::atlas_meshes(aicha_sub())
    expect_setequal(meshes$label, aicha_sub()$core$label)
  })

  it("gives both hemispheres of a parcel the same colour", {
    pal <- ggseg.formats::atlas_palette(aicha_sub())
    parcel <- sub("_(Left|Right)$", "", names(pal))
    per_parcel <- tapply(unname(pal), parcel, function(x) length(unique(x)))
    expect_true(all(per_parcel == 1))
  })

  it("renders with ggseg", {
    skip_if_not_installed("ggseg")
    skip_if_not_installed("vdiffr")
    vdiffr::expect_doppelganger(
      "aicha_sub-2d",
      ggseg::brain_test_plot(aicha_sub())
    )
  })
})
