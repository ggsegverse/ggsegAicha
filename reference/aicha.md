# AICHA Atlas (Atlas of Intrinsic Connectivity of Homotopic Areas)

Brain atlas for the AICHA cortical parcellation with 342 regions. The
original volumetric atlas in MNI space was projected to fsaverage using
the CBIG lab's registration fusion. Contains both 2D polygon geometry
for
[`ggseg::geom_brain()`](https://ggsegverse.github.io/ggseg/reference/ggbrain.html)
and 3D vertex indices for
[`ggseg3d::ggseg3d()`](https://ggsegverse.github.io/ggseg3d/reference/ggseg3d.html).

## Usage

``` r
aicha()
```

## Value

A
[ggseg.formats::ggseg_atlas](https://ggsegverse.github.io/ggseg.formats/reference/ggseg_atlas.html)
object (cortical).

## References

Joliot M, Jobard G, Naveau M, Delcroix N, Petit L, Zago L, ... &
Tzourio-Mazoyer N (2015). AICHA: An atlas of intrinsic connectivity of
homotopic areas. *Journal of Neuroscience Methods*, 254, 46-59.
[doi:10.1016/j.jneumeth.2015.07.013](https://doi.org/10.1016/j.jneumeth.2015.07.013)

## Examples

``` r
aicha()
#> 
#> ── aicha ggseg atlas ───────────────────────────────────────────────────────────
#> Type: cortical
#> Regions: 343
#> Hemispheres: left, right
#> Views: inferior, lateral, superior, medial
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (vertices)
#> ────────────────────────────────────────────────────────────────────────────────
#>    hemi            region                label
#> 1  left G_Frontal_Sup-1-L lh_G_Frontal_Sup-1-L
#> 2  left G_Frontal_Sup-2-L lh_G_Frontal_Sup-2-L
#> 3  left G_Frontal_Sup-3-L lh_G_Frontal_Sup-3-L
#> 4  left S_Sup_Frontal-1-L lh_S_Sup_Frontal-1-L
#> 5  left S_Sup_Frontal-2-L lh_S_Sup_Frontal-2-L
#> 6  left S_Sup_Frontal-3-L lh_S_Sup_Frontal-3-L
#> 7  left S_Sup_Frontal-4-L lh_S_Sup_Frontal-4-L
#> 8  left S_Sup_Frontal-5-L lh_S_Sup_Frontal-5-L
#> 9  left S_Sup_Frontal-6-L lh_S_Sup_Frontal-6-L
#> 10 left G_Frontal_Mid-1-L lh_G_Frontal_Mid-1-L
#> ... with 333 more rows
if (FALSE) plot(aicha()) # \dontrun{}
```
