library(tidyverse)
library(nycflights13)

data(flights)
data(airports)

set.seed(12)
flights_reduced <- flights |>
  select(year, month, day, , hour, minute, flight, origin, dest) |>
  slice_sample(n = 15)

airports_reduced <- airports |>
  select(-c(tz, dst, tzone, alt)) |>
  slice_sample(n = 15)

write_csv(flights_reduced, "data/flights.csv")
writexl::write_xlsx(airports_reduced, "data/airports.xlsx")

flights_reduced
airports_reduced

flights_reduced |>
  anti_join(airports, by = join_by(dest == faa))
