#' AICHA Atlas (Atlas of Intrinsic Connectivity of Homotopic Areas)
#'
#' Brain atlas for the AICHA cortical parcellation with 342 regions.
#' The original volumetric atlas in MNI space was projected to fsaverage
#' using the CBIG lab's registration fusion. Contains both 2D polygon
#' geometry for [ggseg::geom_brain()] and 3D vertex indices for
#' [ggseg3d::ggseg3d()].
#'
#' @family ggseg_atlases
#'
#' @references Joliot M, Jobard G, Naveau M, Delcroix N, Petit L, Zago L,
#'   ... & Tzourio-Mazoyer N (2015). AICHA: An atlas of intrinsic
#'   connectivity of homotopic areas. *Journal of Neuroscience Methods*,
#'   254, 46-59.
#'   \doi{10.1016/j.jneumeth.2015.07.013}
#'
#' @return A [ggseg.formats::ggseg_atlas] object (cortical).
#' @export
#' @examples
#' aicha()
aicha <- function() .aicha
