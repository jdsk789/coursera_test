#this script assumes you have imported the files
#note: need to reimport y_train and features tables!!!
library(plyr) ; library(dplyr)
#combine training and test data sets with proper variable names
df_data = rbind(X_train, X_test)
names(df_data) = features[,2]
#combine x and y labels
colnames(y_train) = 'activity'
colnames(y_test) = 'activity'
df_act = rbind(y_train, y_test)

#regular expression pattern to extract mean and standard deviation
pat = 'mean()|std()'
df_msd = df_data[c(grepl(pat,colnames(df_data)))]
#combine the data sets with only mean and sd with labels
df_msd = cbind(df_msd, df_act)
#Changing the activities labels (df_msd$labels) to readable elements
df_msd['activity'][df_msd['activity']==1] = 'WALKING'
df_msd['activity'][df_msd['activity']==2] = 'WALKING_UPSTAIRS'
df_msd['activity'][df_msd['activity']==3] = 'WALKING_DOWNSTAIRS'
df_msd['activity'][df_msd['activity']==4] = 'SITTING'
df_msd['activity'][df_msd['activity']==5] = 'STANDING'
df_msd['activity'][df_msd['activity']==6] = 'LAYING'
#change the data frame name from df_msd to data
data = df_msd

#create tidy data frame
tidydata = group_by(data, activity)%>%summarize_all(mean)
write.table(tidydata, "TidyData.txt", row.name=FALSE)