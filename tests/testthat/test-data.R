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
