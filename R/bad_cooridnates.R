library(tidyverse)

df <- tibble(
  lon = c("W70° 15' 50", "E20° 15' 03"),
  lat = c("N46° 21' 32", "S6° 53' 02")
)

write_csv(df, "data/deg_min_sec_coordinates.csv")

read_csv("http://tinyurl.com/coordsdms")

df

df <- mutate(
  df,
  lon = str_replace(lon, "W", "-"),
  lat = str_replace(lat, "S", "-")
)

df

df <- df |>
  separate_wider_delim(
    lon,
    delim = " ",
    names = c("deg", "minutes", "seconds"),
    names_sep = "_"
  ) |>
  separate_wider_delim(
    lat,
    delim = " ",
    names = c("deg", "minutes", "seconds"),
    names_sep = "_"
  )

df

df <- df |>
  mutate(across(everything(), parse_number))

df


df <- mutate(
  df,
  lon = lon_deg + (lon_minutes / 60) + (lon_seconds / 3600),
  lat = lat_deg + (lat_minutes / 60) + (lat_seconds / 3600),
  .keep = "unused"
)

df
