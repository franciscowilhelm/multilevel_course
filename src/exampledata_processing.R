df_cfa_long <- read.table(file = "data_simulation/example2itemlevel_rep1.dat", header = FALSE, 
                          na.strings = "*", strip.white = TRUE) |> as_tibble()
names(df_cfa_long) <- c("w1", "w2", "w3", "w4", "w5",
                        "a1", "a2", "a3", "a4", "a5", "b1", "b2", "b3", "b4", "b5", "c1", "c2", "c3", "id")
df_cfa_long <- df_cfa_long |> mutate(t = rep(1:10, 100)) |> select(id, t, everything()) |> select(-starts_with("w"))
df_cfa_wide <- df_cfa_long |> pivot_wider(id_cols = "id", names_from = "t", values_from = starts_with(c("a", "b", "c")),
                                          names_sep = "_t") 
save(df_cfa_wide, file = "data/df_cfa_wide.RData")
