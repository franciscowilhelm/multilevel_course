# Ausschuss

# alternative scaling using broad format


scales_within <- psych::scoreItems(keys = list(a = c("a1", "a2", "a3", "a4", "a5"),
                                               b = c("b1", "b2", "b3", "b4", "b5"),
                                               c = c("c1", "c2", "c3")) , df_example2)
scales_between <- psych::scoreItems(keys = list(w = c("w1", "w2", "w3", "w4", "w5")), df_w)
# join id and within
df_scores <- bind_cols(df_example2 |> select(id),
                       scales_within$scores)
# join between and within
df_scores <- scales_between$scores |> as_tibble() |> rownames_to_column(var = "id") |> mutate(id = as.numeric(id)) |> 
  right_join(df_scores, by = join_by(id))


# SD joined over type sof vars
standardabweichung_w <- scales_between$scores |> sd()

standardabweichung <- bind_cols(tibble(w = standardabweichung_w), standardabweichung)
standardabweichung


#Für schöneren Output bauen wir uns Funktionen mit Rundungen von Werten bauen. Die `tidy_and_round()` und die `model_parameters_r()` Funktion.`model_parameters()` hat zudem eine `print_html()` Funktion, die eine gute Darstellung aus R Markdown Dokumenten HTML-Outputs erlaubt.
#(Die folgende Syntax muss nicht angepasst werden.)

tidy_and_round <- function(model) {
  broom.mixed::tidy(model) |> mutate(across(where(is.numeric), ~round(.x, 2)))
}

tidy_and_round(nullmodel)

model_parameters_r <- function(model) {
  parameters::model_parameters(model) |> mutate(across(where(is.numeric), ~round(.x, 2)))
}

model_parameters_r(nullmodel) |> print_html()
