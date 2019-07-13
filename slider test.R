library(svglite)
library(lattice)
library(ggplot2)
library(rvest) 
library(reshape2)
library(dplyr)
library(htmlwidgets)
library(slickR)
library(xml2)


nbaTeams=c("ATL","BOS","BKN","CHA","CHI","CLE","DAL","DEN","DET","GSW",
           "HOU","IND","LAC","LAL","MEM","MIA","MIL","MIN","NOP","NYK",
           "OKC","ORL","PHI","PHX","POR","SAC","SAS","TOR","UTA","WAS")
teamImg=sprintf("https://i.cdn.turner.com/nba/nba/.element/img/4.0/global/logos/512x512/bg.white/svg/%s.svg",nbaTeams)
a1=read_html('http://www.espn.com/nba/depth')%>%html_nodes(css = '#my-teams-table a')
a2=a1%>%html_attr('href')
a3=a1%>%html_text()
team_table=read_html('http://www.espn.com/nba/depth')%>%html_table()
team_table=team_table[[1]][-c(1,2),]
playerTable=team_table%>%melt(id='X1')%>%arrange(X1,variable)
playerName=a2[grepl('[0-9]',a2)]
playerId=do.call('rbind',lapply(strsplit(playerName,'[/]'),function(x) x[c(8,9)]))

slickR(obj = teamImg,slideId = 'ex1',height = 100,width='100%')
