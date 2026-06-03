install.packages("tidyverse")
install.packages("corrplot")
library(tidyverse)
library(corrplot)
library(ggplot2)

df <- read_csv(file.choose(), n_max = 20000)

head(df, 3)

df <- df %>% mutate(discount_price = as.numeric(str_remove_all(discount_price, "₹,")))

summary(df$discount_price)

df <- df %>% mutate(discount_price = as.numeric(str_remove_all(discount_price, "[₹,]")))

summary(df$discount_price)

colnames(df)

df$discount_price[1:5]

rm(df)
df <- read_csv("amazon.csv", n_max = 20000, 
               col_types = cols(discount_price = col_character(), 
                                actual_price = col_character()))

df$discount_price[1:5]

df <- df %>% mutate(discount_price = as.numeric(str_remove_all(discount_price, "[^0-9]")),
                    actual_price = as.numeric(str_remove_all(actual_price, "[^0-9]")))
summary(df$discount_price)
numeric_df <- df %>% select(ratings, no_of_ratings, discount_price, actual_price) %>% drop_na()
cor_matrix <- cor(numeric_df)
cor_matrix

str(numeric_df)
numeric_df <- df %>% select(ratings, no_of_ratings, discount_price, actual_price) %>% 
  mutate(ratings = as.numeric(ratings),
         no_of_ratings = as.numeric(str_remove_all(no_of_ratings, "[^0-9]"))) %>% 
  drop_na()
str(numeric_df)

cor_matrix <- cor(numeric_df)
cor_matrix
corrplot(cor_matrix, method = "color", addCoef.col = "black", tl.cex = 0.8)

corrplot(cor_matrix, method = "color", addCoef.col = "black", tl.cex = 0.8)

ggplot(numeric_df, aes(x = discount_price, y = ratings)) + 
  geom_point(alpha = 0.3) + 
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Price vs Rating", x = "Discount Price", y = "Rating")

