mlmediation_wrapper <- function(x, y, m, id, df, cores = 4, seed = 1234,
                                randomcor = TRUE) {
  dat.restruct <- stack_bpg(df, L2ID = id, X = x, Y = y, M = m)
  if(randomcor) {
    model_formula <- bf(formula = Z ~ 0 + Sm + SmX + Sy + SyM + SyX +
                          (0 + Sm + SmX + Sy + SyM + SyX | L2id),
                        sigma ~ 0+ Sm + Sy)
  } else if(randomcor == FALSE) {
    model_formula <- bf(formula = Z ~ 0 + Sm + SmX + Sy + SyM + SyX +
                          (0 + Sm + SmX + Sy + SyM + SyX || L2id),
                        sigma ~ 0+ Sm + Sy)
  }

  fit.brms <- brm(model_formula,
                  data = dat.restruct, family = gaussian,
                  iter = 2500 , control = list(adapt_delta=0.95),
                  seed = seed,
                  cores= cores)
  
}

extract_indirect <- function(fit) {
  a_brms <- as.data.frame(as_draws(fit, variable = "b_SmX"))
  b_brms <- as.data.frame(as_draws(fit, variable = "b_SyM"))
  ab_brms <- as.mcmc(a_brms*b_brms)
  summary_ab <- summary(ab_brms)
  out <- data.frame(Estimate = mean(summary_ab[["quantiles"]][,3]) |> round(4),
                    CI95LL = mean(summary_ab[["quantiles"]][,1]) |> round(4),
                    CI95UL = mean(summary_ab[["quantiles"]][,5]) |> round(4))
  return(out)
}

