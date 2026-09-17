# AICHA Subcortical Atlas

Subcortical half of the AICHA parcellation, with 20 parcels per
hemisphere covering amygdala, caudate, pallidum, putamen and thalamus.
Parcels are numbered within each structure, as AICHA names them. Drawn
in four views, two coronal and two axial, with the surrounding brain in
grey for anatomical context. Contains 2D polygon geometry for
[`ggseg::geom_brain()`](https://ggsegverse.github.io/ggseg/reference/ggbrain.html)
and 3D mesh data for
[`ggseg3d::ggseg3d()`](https://ggsegverse.github.io/ggseg3d/reference/ggseg3d.html).

## Usage

``` r
aicha_sub()
```

## Value

A
[ggseg.formats::ggseg_atlas](https://ggsegverse.github.io/ggseg.formats/reference/ggseg_atlas.html)
object (subcortical).

## Details

The published subcortical volume was embedded in the fsaverage5 `aseg`
through the fixed MNI152 registration, so the parcels are drawn in
anatomical context rather than floating. Colour follows the structure:
one hue per structure, with its numbered parcels in shades of that hue.

For the cortical half of AICHA see
[`aicha()`](https://ggseg.github.io/ggsegAicha/reference/aicha.md).

## References

Joliot M, Jobard G, Naveau M, Delcroix N, Petit L, Zago L, ... &
Tzourio-Mazoyer N (2015). AICHA: An atlas of intrinsic connectivity of
homotopic areas. *Journal of Neuroscience Methods*, 254, 46-59.
[doi:10.1016/j.jneumeth.2015.07.013](https://doi.org/10.1016/j.jneumeth.2015.07.013)

## See also

Other ggseg_atlases:
[`aicha()`](https://ggseg.github.io/ggsegAicha/reference/aicha.md)

## Examples

``` r
aicha_sub()
#> 
#> ── aicha_sub ggseg atlas ───────────────────────────────────────────────────────
#> Type: subcortical
#> Regions: 20
#> Hemispheres: left, right
#> Views: axial_1, axial_2, coronal_1, coronal_2
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (meshes)
#> ────────────────────────────────────────────────────────────────────────────────
#>     hemi     region            label
#> 1   left amygdala 1  Amygdala_1_Left
#> 2  right amygdala 1 Amygdala_1_Right
#> 3   left  caudate 1   Caudate_1_Left
#> 4  right  caudate 1  Caudate_1_Right
#> 5   left  caudate 2   Caudate_2_Left
#> 6  right  caudate 2  Caudate_2_Right
#> 7   left  caudate 3   Caudate_3_Left
#> 8  right  caudate 3  Caudate_3_Right
#> 9   left  caudate 4   Caudate_4_Left
#> 10 right  caudate 4  Caudate_4_Right
#> ... with 30 more rows
if (FALSE) plot(aicha_sub()) # \dontrun{}
```
