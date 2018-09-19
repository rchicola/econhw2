#chapter 5 exercise

#read in the data:

#set the file path for the dta file
file_path<-"/home/appertjt/Documents/Grad School/econometrics fall/Code/chap5/CH5_HW.dta"
file_path2<-"/home/appertjt/Documents/Grad School/econometrics fall/Code/chap5/CH5_HW.csv"

#import the foreign package
#install.packages("readstata13")
library(foreign)
library("readstata13")

#read the file in

data<-read.dta13(file_path)

#df1<-subset(data, age != "Less than 1 year old")

#save the filtered file as a csv
write.csv(df1, file=file_path2)

#load data into a dataframe

df1.d<-data.frame(df1)
#convert all columns to numeric values
df1.d<-transform(df1.d, incwage=as.numeric(incwage), uhrswork=as.numeric(uhrswork), age=as.numeric(age))

#drop columns where wage == 999999 AND where wage>0
#Note, we should be able to do this in one step.  Need to look at filtering by multiple arguments

df1.d<-df1.d[df1.d["incwage"]<900000,]
df1.d<-df1.d[df1.d['incwage']>0,]

#assign the independent and dependent variables

y<-as.matrix(df1.d["incwage"])
x<-as.matrix(df1.d["uhrswork"])

#create a column of constants
cons<-matrix(nrow=nrow(x), ncol=1,1)
xmat<-cbind(x, cons)

#find betaHat

betaHat<-(solve(t(xmat)%*%xmat))%*%(t(xmat)%*%y)
print (betaHat)

#get the predicted y values
yHat=xmat%*%betaHat

#get the residuals
epsilonHat=y-yHat

#get sigmaHat
sigmaHat<-(t(epsilonHat)%*%epsilonHat)/(nrow(x)-ncol(x))

##problems start here
se=sigmaHat[1]*solve(t(xmat)%*%(xmat))

print(sqrt(diag(se)))
varBeta=solve(t(xmat)%*%xmat)
print (varBeta)

reg = lm(incwage ~ uhrswork, data=df1.d)
summary(reg)
