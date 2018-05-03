species<-c("Aira.caryophylla",
"Avena.barbata",
"Briza.maxima","Bromus.rubens",
"Ehrharta.longiflora",
"Pentaschistis.airoides",
"Vulpia.bromoides","Vulpia.sp", "Austrostipa.elegantissima",
"Blennospora.drummondii",
"Brachyscome.iberidifolia", "Calandrinia.eremaea",
"Ceratogyne.obionoides","Crassula.sp",
"Gnephosis.tenuissima","Gonocarpus.nodulosus",
"Goodenia.sp","Hyalosperma.demissum",
"Hydrocotyle.pilifera" ,"Lawrencella.rosea",
"Lobelia.gibbosa" ,"Neurachne.alopecuroidea",
"Nicotiana.rotundifolia","Phyllangium.sulcatum",
"Podolepis.lessonii","Podotheca.angustifolia",
"Podotheca.gnaphalioides","Poranthera.microphylla",
"Rhodanthe.citrina","Rhodanthe.laevis",
"Rhodanthe.manglesii","Thysanotus.rectantherus",
"Trachymene.cyanopetala","Trachymene.ornata",
"Trachymene.pilosa","Triglochin.isingiana",
"Wahlenbergia.gracilenta","Waitzia.acuminata",
"Brassica.tournefortii","Hypochaeris.glabra",
"Lysimachia.arvensis","Oxalis.sp",
"Petrorhagia.dubia","Ursinia.anthemoides",
"Zaluzianskya.divaricata","Parentucellia.latifolia",
"Arctotheca.calendula")

species %in% raw.trait$species

trace.trait<-raw.trait[which(raw.trait$species %in% species),]

cool<-aggregate(raw.trait$species, by=list(raw.trait$remnant), FUN=summary)

seed.mass<-na.omit(aggregate(raw.trait$mean.seed.mass, by=list(raw.trait$species,raw.trait$remnant),FUN=mean))

head(raw.trait)
data.frame(do.call("rbind",strsplit(as.character(raw.trait$life.form),".",2)))
#install.packages('tidyr')
 library(tidyr)
raw.trait$life.form<-as.character(raw.trait$life.form)

unique(raw.trait$life.form)

xx<-str_split_fixed(as.character(raw.trait$life.form),pattern="\\.",n=3)
unique(xx[,3])

for (i in 1:length(xx[,3])) {
if (xx[,3]=="forb" | xx[,3]=="twiner") {
  
}
