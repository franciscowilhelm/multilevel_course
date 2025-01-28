library(tidyverse)
df_cfa_long <- read.table(file = "data_simulation/example2itemlevel_rep1.dat", header = FALSE, 
                          na.strings = "*", strip.white = TRUE) |> as_tibble()
names(df_cfa_long) <- c("w1", "w2", "w3", "w4", "w5",
                        "a1", "a2", "a3", "a4", "a5", "b1", "b2", "b3", "b4", "b5", "c1", "c2", "c3", "id")
df_cfa_long <- df_cfa_long |> mutate(t = rep(1:10, 100)) |> select(id, t, everything()) |> select(-starts_with("w"))
df_cfa_wide <- df_cfa_long |> pivot_wider(id_cols = "id", names_from = "t", values_from = starts_with(c("a", "b", "c")),
                                          names_sep = "_t") 
save(df_cfa_wide, file = "data/df_cfa_wide.RData")

df_cfa_exercise <- read.table(file = "data_simulation/example2b_exercise_rep1.dat", header = FALSE, 
                          na.strings = "*", strip.white = TRUE) |> as_tibble()
names(df_cfa_exercise) <- c("w1", "w2", "w3", "w4", "w5",
                        "x1", "x2", "x3", "x4", "x5", "y1", "y2", "y3", "y4", "y5", "id")
df_cfa_exercise <- df_cfa_exercise |> mutate(t = rep(1:10, 100)) |> select(id, t, everything()) |> select(-starts_with("w"))
df_cfa_exercise <- df_cfa_exercise |> pivot_wider(id_cols = "id", names_from = "t", values_from = starts_with(c("x", "y")),
                                          names_sep = "_t") 
save(df_cfa_exercise, file = "data/df_cfa_exercise.RData")


df_example1c <- read.table(file = "data_simulation/example1crep2.dat", header = FALSE, 
                          na.strings = "*", strip.white = TRUE) |> as_tibble()
names(df_example1c) <- c("w", "y", "x", "m", "id")
df_example1c <- df_example1c |> select(id, everything())

df_example1c <- df_example1c |>
  mutate(id = as.factor(id)) |> 
  de_mean(y, m, x, grp = "id")
head(df_example1c)

save(df_example1c, file = "data/df_example1c.RData")
# df_example1
df_example1 <- read.table(file = "data_simulation/example1rep2.dat", header = FALSE, 
                          na.strings = "*", strip.white = TRUE) |> as_tibble()
names(df_example1) <- c("y", "x", "m", "id")
df_example1 <- df_example1 |> select(id, everything())
df_example1 <- df_example1 |> 
  mutate(id = as.factor(id)) |> 
  de_mean(y, m, x, grp = "id")
head(df_example1)

save(df_example1, file = "data/df_example1.RData")

# 1-1-1 Alt version, no significant b path
df_111_uebung <- read.table(file = "data_simulation/example1_altrep1.dat", header = FALSE, 
                          na.strings = "*", strip.white = TRUE) |> as_tibble()
names(df_111_uebung) <- c("helfen", "wertschaetz", "selbstwert", "id")
df_111_uebung <- df_111_uebung |> select(id, everything())

df_111_uebung <- df_111_uebung |> 
  mutate(id = as.factor(id)) |> 
  de_mean(wertschaetz, selbstwert, grp = "id")
head(df_111_uebung)

df_111_uebung <- df_111_uebung |>
  sjlabelled::var_labels(
    id = "Personen-ID",
    helfen = "Proaktives Helfen",
    wertschaetz = "erfahrene Wertschaetzung",
    wertschaetz_gm = "erfahrene Wertschaetzung (person average)",
    wertschaetz_dm = "erfahrene Wertschaetzung (person-mean centered)",
    selbstwert = "Selbstwert",
    selbstwert_dm = "Selbstwert (person-mean centered)",
    selbstwert_gm = "Selbstwert (person average)",
  )

save(df_111_uebung, file = "data/df_111_uebung.RData")
