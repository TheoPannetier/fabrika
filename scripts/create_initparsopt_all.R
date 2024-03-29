source("R/create_comsie_initparsopt_ddd.R")
source("R/create_comsie_initparsopt_daisie.R")

expand_grid(
  "siga" = c(0.369, 0.091),
  "gamma" = c(5e-04, 1e-02),
  "i" = 1:100,
  "f" = 0.5
) %>%
 pwalk(function(siga, gamma, i, f) {
  if (gamma %in% c(5e-04) && i == 62) return()
  create_comsie_initparsopt_ddd(siga, gamma, i, f)
})

expand_grid(
  "siga" = c(0.091, 0.369),
  "gamma" = c(1e-03),
  "i" = 1:100,
  "f" = 1
) %>%
  pwalk(function(siga, gamma, i, f) {
    create_comsie_initparsopt_daisie(siga, gamma, i, f)
  })

