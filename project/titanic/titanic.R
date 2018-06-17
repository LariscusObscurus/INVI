mosaicplot(Titanic, main = "Survival on the Titanic")

mosaicplot(~ Class + Survived, data = Titanic, color = TRUE)
# 3rd class survival rate seems higher than crew survival rate
# but:
mosaicplot(~ Class + Sex + Survived, data = Titanic, color = TRUE)
# both male & female survival rates are higher in Crew
# numeric: apply(Titanic, c(1,2,4), sum)
