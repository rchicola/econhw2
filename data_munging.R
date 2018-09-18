#set the file path for the dta file
file_path<-"/home/appertjt/Documents/Grad School/econometrics fall/Code/chap5/CH5_HW.dta"
file_path2<-"/home/appertjt/Documents/Grad School/econometrics fall/Code/chap5/CH5_HW.csv"

#import the foreign package
install.packages("readstata13")
library(foreign)
library("readstata13")

#read the file in

data<-read.dta13(file_path)

df1<-subset(data, age != "Less than 1 year old")

write.csv(df1, file=file_path2)
