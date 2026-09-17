# Changelog

## ggsegAicha 2.1.0

- Added
  [`aicha_sub()`](https://ggseg.github.io/ggsegAicha/reference/aicha_sub.md),
  the subcortical half of the AICHA parcellation: 20 parcels per
  hemisphere across amygdala, caudate, pallidum, putamen and thalamus,
  drawn in two coronal and two axial views on a grey brain silhouette,
  with 3D meshes.

## ggsegAicha 2.0.2

- Atlas 2D geometry migrated to the sf-optional `brain_polygons` format
  (`ggseg.formats` 0.0.3). The atlases now render without `sf` and its
  GDAL/GEOS/PROJ system libraries, enabling wasm and air-gapped
  installs. Plots are unchanged.

## ggsegAicha 2.0.0

### Breaking changes

- `aicha` is now a `ggseg_atlas` object (from ggseg.formats) containing
  both 2D and 3D data. The separate `aicha_3d` object has been removed.

- Use `ggplot() + ggseg::geom_brain(atlas = aicha)` for 2D plots and
  `ggseg3d::ggseg3d(atlas = aicha)` for 3D plots — both from the same
  object.

- `ggseg.formats` is now a hard dependency (in Depends).

- Package URLs updated from `LCBC-UiO` to `ggseg` GitHub organisation.
