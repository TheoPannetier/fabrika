run_dd_ml_hpc_simtrees <- function(siga, sigk, ddmod_sim, dd_model) {
  if (!fabrika::is_on_peregrine()) {
    stop("This function is only intended to be run on the Peregrine HPC.")
  }
  cat(
    glue::glue("siga = {siga} sigk = {sigk}\nFitting DD model {dd_model$name} on trees simulated with DD model {ddmod_sim}\n\n")
  )
  # Load data
  phylos <- readRDS(
    glue::glue("/data/p282688/fabrika/comrad_data/phylos/dd_phylos_{ddmod_sim}_sigk_{sigk}_siga_{siga}.rds")
  )
  waiting_times_tbl <- purrr::map_dfr(phylos, comrad::waiting_times)
  # Draw initial parameter values
  init_params_ls <- comrad::draw_init_params_dd_ml(
    phylos = phylos,
    nb_sets = 1000,
    dd_model = dd_model
  )
  # Run ml for each initial parameter set
  ml <- purrr::imap_dfr(
    init_params_ls,
    function(init_params, i) {
      cat("init params:", i , "/", length(init_params_ls), "\n")
      print(init_params)
      comrad::fit_dd_model_with_fossil(
        waiting_times_tbl = waiting_times_tbl,
        dd_model = dd_model,
        init_params = init_params,
        num_cycles = Inf
      )
    })
  # Save output
  saveRDS(
    ml,
    glue::glue(
      "/data/p282688/fabrika/comrad_data/ml_results/ml_{dd_model$name}_sim_{ddmod_sim}_sigk_{sigk}_siga_{siga}_2.rds")
  )
}
