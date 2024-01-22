library(tidyverse)
library(nycflights13)

data(flights)
data(airports)

set.seed(2023)
flights_reduced <- flights |>
  select(year, month, day, , hour, minute, flight, origin, dest, distance) |>
  slice_sample(n = 15)

airports_reduced <- airports |>
  inner_join(
    flights_reduced |> select(dest) |> slice_sample(n = 10),
    by = join_by(faa == dest)
  ) |>
  distinct(faa, .keep_all = TRUE) |>
  bind_rows(slice_sample(airports, n = 6)) |>
  distinct(faa, .keep_all = TRUE) |>
  select(-c(tz, dst, tzone, alt))


write_csv(flights_reduced, "data/flights.csv")
write_csv(airports_reduced, "data/airports.csv")

flights_reduced
airports_reduced

flights_reduced |>
  anti_join(airports_reduced, by = join_by(dest == faa))


write_csv(relig_income, "data/relig_income.csv")

read_csv("http://tinyurl.com/religionincome")

write_csv(who2, "data/who_tb.csv")

tb <- read_csv("http://tinyurl.com/whotuber")
tb

tb_pivot <- pivot_longer(tb, !c(country, year), values_to = "count", names_to = "demo")
tb_pivot

separate_wider_delim(tb_pivot, demo, delim = "_", names = c("case", "sex", "age_group"))
