targets::tar_test("geotargets_options_get() retrieves options in correct priority", {
    #options takes precedent over env var
    withr::with_envvar(
        c("GEOTARGETS_GDAL_RASTER_DRIVER" = "COG"),
        withr::with_options(list("geotargets.gdal.raster.driver" = "GIF"), {
            targets::tar_script({
                list(
                    targets::tar_target(
                        opt,
                        geotargets::geotargets_option_get("gdal.raster.driver")
                    )
                )
            })
            targets::tar_make()
            expect_equal(geotargets::geotargets_option_get("gdal.raster.driver"), "GIF")
        })

    )
})

test_that("geotargets_option_set() works", {
    geotargets_option_set(gdal_raster_driver = "COG")
    expect_equal(getOption("geotargets.gdal.raster.driver"), "COG")
    expect_equal(geotargets_option_get("gdal.raster.driver"), "COG")
    expect_equal(geotargets_option_get("gdal_raster_driver"), "COG")
})

