# install.packages("recommenderlab")
library(recommenderlab)
library(reshape2)

####### Example: Data generated in class #####
attach(bookR)

bookR <- read.csv(choose.files())

summary(bookR)
bookR <- bookR[,2:4]
head(bookR)
dim(bookR)
str(bookR)


## covert to matrix format
?acast

bookR_matrix <- as.matrix(acast(bookR, User.ID~Book.Rating, fun.aggregate = mean))
dim(bookR_matrix)

## recommendarlab realRatingMatrix format
R <- as(bookR_matrix, "realRatingMatrix")
?realRatingMatrix

rec1 = Recommender(R, method="UBCF") ## User-based collaborative filtering
rec2 = Recommender(R, method="IBCF") ## Item-based collaborative filtering
rec3 = Recommender(R, method="POPULAR")
rec4 = Recommender(binarize(R,minRating=2), method="UBCF") ## binarize all 2+ rating to 1

## create n recommendations for a user
uid = "276736"


movies <- subset(bookR, bookR$Book.Title==uid)
print("You have rated:")
movies



print("recommendations for you:")
prediction1 <- predict(rec1, R[uid], n=3) 
as(prediction1, "list")

prediction2 <- predict(rec2, R[uid], n=3) 
as(prediction2, "list")

prediction3 <- predict(rec3, R[uid], n=4) 
as(prediction3, "list")

prediction4 <- predict(rec4, R[uid], n=4)
as(prediction4, "list")

prediction5 <- predict(rec5, R[uid], n=2) 
as(prediction5, "list")


