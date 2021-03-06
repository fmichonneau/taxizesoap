taxizesoap
=======

[![Build Status](https://api.travis-ci.org/ropensci/taxizesoap.png?branch=master)](https://travis-ci.org/ropensci/taxizesoap)

`taxizesoap` is an extension to [taxize](https://github.com/ropensci/taxize), but for data sources that use SOAP data transfer protocol, which is hard to support in R. This package won't go on CRAN.

Most functions in this package are different from those in `taxize`, but there are some of the same (e.g,. `classification()`). In this package, where a function is named the same as in `taxize`, I've added a `_s` at the end of the function representing the version of that function in the `taxizesoap` package. This is to avoid confounding effects when both packages are loaded at the same time.

### Currently implemented in `taxizesoap`

<table>
<colgroup>
<col style="text-align:left;"/>
<col style="text-align:left;"/>
<col style="text-align:left;"/>
<col style="text-align:left;"/>
</colgroup>

<thead>
<tr>
  <th style="text-align:left;">Souce</th>
	<th style="text-align:left;">Function prefix</th>
	<th style="text-align:left;">API Docs</th>
	<th style="text-align:left;">API key</th>
</tr>
</thead>

<tbody>
<tr>
	<td style="text-align:left;">World Register of Marine Species (WoRMS)</td>
	<td style="text-align:left;"><code>worms</code></td>
	<td style="text-align:left;"><a href="http://www.marinespecies.org/aphia.php?p=webservice">link</a></td>
	<td style="text-align:left;">none</td>
</tr>
<tr>
	<td style="text-align:left;">Pan-European Species directories Infrastructure (PESI)</td>
	<td style="text-align:left;"><code>pesi</code></td>
	<td style="text-align:left;"><a href="http://www.eu-nomen.eu/portal/webservices.php">link</a></td>
	<td style="text-align:left;">none</td>
</tr>
<tr>
	<td style="text-align:left;">Mycobank</td>
	<td style="text-align:left;"><code>myco</code></td>
	<td style="text-align:left;"><a href="http://www.mycobank.org/Services/Generic/Help.aspx?s=searchservice">link</a></td>
	<td style="text-align:left;">none</td>
</tr>
</tbody>
</table>

**Note:** Euro+Med is available through PESI.

## Install taxizesoap

You'll need `XMLSchema` and `SSOAP`. I have versions of these packages on my personal GitHub account that seem to work better than the versions on Omegahat, and from there you can take advantage of the easy `install_github()`.


```r
install.packages("devtools")
devtools::install_github(c("sckott/XMLSchema", "sckott/SSOAP"))
```

Then install `taxizesoap`


```r
devtools::install_github("ropensci/taxizesoap")
```

Load the package


```r
library('taxizesoap')
```

### Get taxonomic ids

PESI


```r
get_pesiid(searchterm = "Salvelinus")
```

```
## 
## Retrieving data for taxon 'Salvelinus'
```

```
## [1] "urn:lsid:marinespecies.org:taxname:126142"
## attr(,"match")
## [1] "found"
## attr(,"uri")
## [1] "http://www.eu-nomen.eu/portal/taxon.php?GUID=urn:lsid:marinespecies.org:taxname:126142"
## attr(,"class")
## [1] "pesiid"
```

Worms


```r
get_wormsid(searchterm = "Salvelinus fontinalis")
```

```
## 
## Retrieving data for taxon 'Salvelinus fontinalis'
```

```
## [1] "154241"
## attr(,"match")
## [1] "found"
## attr(,"uri")
## [1] "http://www.marinespecies.org/aphia.php?p=taxdetails&id=154241"
## attr(,"class")
## [1] "wormsid"
```

### Use taxonomic ids for more

Get taxonomic classification


```r
classification_s(get_wormsid("Salvelinus fontinalis"))
```

```
## 
## Retrieving data for taxon 'Salvelinus fontinalis'
```

```
## $`154241`
##                     name       rank
## 1               Animalia    Kingdom
## 2               Chordata     Phylum
## 3             Vertebrata  Subphylum
## 4          Gnathostomata Superclass
## 5                 Pisces Superclass
## 6         Actinopterygii      Class
## 7          Salmoniformes      Order
## 8             Salmonidae     Family
## 9             Salmoninae  Subfamily
## 10            Salvelinus      Genus
## 11 Salvelinus fontinalis    Species
## 
## attr(,"class")
## [1] "classification_s"
```

### WORMS

Get name from a WORMS id


```r
worms_name(ids=1080)
```

```
## [1] "Copepoda"
```

Common names from WoRMS ID


```r
worms_common(ids=c(1080,22388,160281,123080,22388))
```

```
##    inputid       vernacular language_code                    language
## 1     1080         copepods           eng                     English
## 2     1080      hoppkräftor           swe                     Swedish
## 3     1080 roeipootkreeften           dut                       Dutch
## 4    22388        barnacles           eng                     English
## 5   160281       dierluizen           dut                       Dutch
## 6   160281         djurlöss           swe                     Swedish
## 7   160281             lice           eng                     English
## 8   160281    phthiraptères           fra                      French
## 9   160281        Tierläuse           deu                      German
## 10  123080         astéries           fra                      French
## 11  123080  estrella de mar           spa                     Spanish
## 12  123080   étoiles de mer           fra                      French
## 13  123080  hitode (ヒトデ)           jpn                    Japanese
## 14  123080        sea stars           eng                     English
## 15  123080        Seesterne           deu                      German
## 16  123080      sjöstjärnor           swe                     Swedish
## 17  123080         starfish           eng                     English
## 18  123080   tapak sulaiman           zlm Malay (individual language)
## 19  123080       zeesterren           dut                       Dutch
## 20  123080         불가사리           kor                      Korean
## 21   22388        barnacles           eng                     English
```

Get records by ID, scientific name, common name, date, worms id, or external id.


```r
head( worms_records(scientific=c('Salmo','Aphanius')) )
```

```
##   inputid AphiaID
## 1   Salmo  126141
## 2   Salmo  154470
## 3   Salmo  154471
## 4   Salmo  712455
## 5   Salmo  305943
## 6   Salmo  305944
##                                                             url
## 1 http://www.marinespecies.org/aphia.php?p=taxdetails&id=126141
## 2 http://www.marinespecies.org/aphia.php?p=taxdetails&id=154470
## 3 http://www.marinespecies.org/aphia.php?p=taxdetails&id=154471
## 4 http://www.marinespecies.org/aphia.php?p=taxdetails&id=712455
## 5 http://www.marinespecies.org/aphia.php?p=taxdetails&id=305943
## 6 http://www.marinespecies.org/aphia.php?p=taxdetails&id=305944
##              scientificname        authority     rank
## 1                     Salmo   Linnaeus, 1758    Genus
## 2           Salmo (Osmerus)   Linnaeus, 1758 Subgenus
## 3 Salmo (Osmerus) eperlanus (Linnaeus, 1758)  Species
## 4           Salmo abanticus  Tortonese, 1954  Species
## 5              Salmo albula   Linnaeus, 1758  Species
## 6               Salmo albus Bonnaterre, 1788  Species
##                     status unacceptreason valid_AphiaID
## 1                 accepted           <NA>        126141
## 2                 accepted           <NA>        154470
## 3 alternate representation        synonym        154774
## 4                 accepted           <NA>        712455
## 5               unaccepted           <NA>        127178
## 6               unaccepted           <NA>        223866
##            valid_name  valid_authority  kingdom   phylum          class
## 1               Salmo   Linnaeus, 1758 Animalia Chordata Actinopterygii
## 2     Salmo (Osmerus)   Linnaeus, 1758 Animalia Chordata Actinopterygii
## 3     Salmo eperlanus   Linnaeus, 1758 Animalia Chordata Actinopterygii
## 4     Salmo abanticus  Tortonese, 1954 Animalia Chordata Actinopterygii
## 5    Coregonus albula (Linnaeus, 1758) Animalia Chordata Actinopterygii
## 6 Salmo trutta trutta   Linnaeus, 1758 Animalia Chordata Actinopterygii
##           order     family genus
## 1 Salmoniformes Salmonidae Salmo
## 2 Salmoniformes Salmonidae Salmo
## 3 Salmoniformes Salmonidae Salmo
## 4 Salmoniformes Salmonidae Salmo
## 5 Salmoniformes Salmonidae Salmo
## 6 Salmoniformes Salmonidae Salmo
##                                                                                                                                                                                                                                        citation
## 1            Bailly, N. (2014). Salmo Linnaeus, 1758. In: Froese, R. and D. Pauly. Editors. (2014) FishBase. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=126141 on 2014-11-22
## 2       WoRMS (2014). Salmo (Osmerus) Linnaeus, 1758. In: Froese, R. and D. Pauly. Editors. (2014) FishBase. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=154470 on 2014-11-22
## 3                                                              Bailly, N. (2014). Salmo (Osmerus) eperlanus. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=154471 on 2014-11-22
## 4 Bailly, N. (2014). Salmo abanticus Tortonese, 1954. In: Froese, R. and D. Pauly. Editors. (2014) FishBase. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=712455 on 2014-11-22
## 5     Bailly, N. (2014). Salmo albula Linnaeus, 1758. In: Froese, R. and D. Pauly. Editors. (2014) FishBase. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=305943 on 2014-11-22
## 6    Bailly, N. (2014). Salmo albus Bonnaterre, 1788. In: Froese, R. and D. Pauly. Editors. (2014) FishBase. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=305944 on 2014-11-22
##                                        lsid isMarine isBrackish
## 1 urn:lsid:marinespecies.org:taxname:126141        1          0
## 2 urn:lsid:marinespecies.org:taxname:154470     <NA>       <NA>
## 3 urn:lsid:marinespecies.org:taxname:154471        1          1
## 4 urn:lsid:marinespecies.org:taxname:712455        1          1
## 5 urn:lsid:marinespecies.org:taxname:305943        1          1
## 6 urn:lsid:marinespecies.org:taxname:305944        1          1
##   isFreshwater isTerrestrial isExtinct match_type             modified
## 1            0          <NA>      <NA>       like 2014-11-21T14:09:38Z
## 2         <NA>          <NA>      <NA>       like 2005-04-18T10:19:09Z
## 3            1             0      <NA>       like 2013-03-22T14:42:51Z
## 4            1          <NA>      <NA>       like 2012-12-21T13:57:20Z
## 5            1          <NA>      <NA>       like 2008-02-28T14:41:08Z
## 6            1             0      <NA>       like 2013-01-08T15:50:09Z
```

Get sources/references by ID


```r
worms_sources(ids=1080)
```

```
##   inputid source_id             use
## 1    1080        40 basis of record
##                                                                                                                 reference
## 1 Brusca, R.C.; Brusca, G.J. (1990). Invertebrates. Sinauer Associates: Sunderland, MA (USA). ISBN 0-87893-098-1. 922 pp.
##   page                                                          url link
## 1      http://www.marinespecies.org/aphia.php?p=sourcedetails&id=40     
##   fulltext
## 1
```

Children search of WoRMS data.


```r
head( worms_children(ids=106135) )
```

```
##   inputid AphiaID
## 1  106135  733743
## 2  106135  106242
## 3  106135  733262
## 4  106135  733744
## 5  106135  733263
## 6  106135  733264
##                                                             url
## 1 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733743
## 2 http://www.marinespecies.org/aphia.php?p=taxdetails&id=106242
## 3 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733262
## 4 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733744
## 5 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733263
## 6 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733264
##           scientificname             authority    rank     status
## 1      Hexelasma alearum            Hoek, 1913 Species unaccepted
## 2   Hexelasma americanum         Pilsbry, 1916 Species   accepted
## 3     Hexelasma arafurae            Hoek, 1913 Species   accepted
## 4 Hexelasma aucklandicum        (Hector, 1888) Species unaccepted
## 5     Hexelasma aureolum           Jones, 2000 Species   accepted
## 6     Hexelasma brintoni (Newman & Ross, 1971) Species   accepted
##                                unacceptreason valid_AphiaID
## 1                        generic reassignment        292966
## 2                                        <NA>        106242
## 3                                        <NA>        733262
## 4 transferred to Bathylasma (see Jones, 2000)        733253
## 5                                        <NA>        733263
## 6                                        <NA>        733264
##                valid_name       valid_authority  kingdom     phylum
## 1      Bathylasma alearum        (Foster, 1978) Animalia Arthropoda
## 2    Hexelasma americanum         Pilsbry, 1916 Animalia Arthropoda
## 3      Hexelasma arafurae            Hoek, 1913 Animalia Arthropoda
## 4 Bathylasma aucklandicum        (Hector, 1887) Animalia Arthropoda
## 5      Hexelasma aureolum           Jones, 2000 Animalia Arthropoda
## 6      Hexelasma brintoni (Newman & Ross, 1971) Animalia Arthropoda
##         class    order          family     genus
## 1 Maxillopoda Sessilia Pachylasmatidae Hexelasma
## 2 Maxillopoda Sessilia Pachylasmatidae Hexelasma
## 3 Maxillopoda Sessilia Pachylasmatidae Hexelasma
## 4 Maxillopoda Sessilia Pachylasmatidae Hexelasma
## 5 Maxillopoda Sessilia Pachylasmatidae Hexelasma
## 6 Maxillopoda Sessilia Pachylasmatidae Hexelasma
##                                                                                                                                                                                     citation
## 1             WoRMS (2014). Hexelasma alearum Hoek, 1913. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733743 on 2014-11-22
## 2       WoRMS (2014). Hexelasma americanum Pilsbry, 1916. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=106242 on 2014-11-22
## 3            WoRMS (2014). Hexelasma arafurae Hoek, 1913. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733262 on 2014-11-22
## 4    WoRMS (2014). Hexelasma aucklandicum (Hector, 1888). Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733744 on 2014-11-22
## 5           WoRMS (2014). Hexelasma aureolum Jones, 2000. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733263 on 2014-11-22
## 6 WoRMS (2014). Hexelasma brintoni (Newman & Ross, 1971). Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733264 on 2014-11-22
##                                        lsid isMarine isBrackish
## 1 urn:lsid:marinespecies.org:taxname:733743        1       <NA>
## 2 urn:lsid:marinespecies.org:taxname:106242        1       <NA>
## 3 urn:lsid:marinespecies.org:taxname:733262        1       <NA>
## 4 urn:lsid:marinespecies.org:taxname:733744        1       <NA>
## 5 urn:lsid:marinespecies.org:taxname:733263        1       <NA>
## 6 urn:lsid:marinespecies.org:taxname:733264        1       <NA>
##   isFreshwater isTerrestrial isExtinct match_type             modified
## 1         <NA>          <NA>      <NA>      exact 2013-07-03T10:40:33Z
## 2         <NA>          <NA>      <NA>      exact 2004-12-21T16:54:05Z
## 3         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
## 4         <NA>          <NA>      <NA>      exact 2013-07-03T10:40:33Z
## 5         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
## 6         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
```

### PESI

Search for PESI scientific names and associated metadata.


```r
pesi_search(scientific='Ternatea vulgaris')
```

```
##               input                                 GUID
## 1 Ternatea vulgaris 67C3CC9C-624A-40C5-B63A-AB880E0300D1
##                                                                                 url
## 1 http://www.eu-nomen.eu/portal/taxon.php?GUID=67C3CC9C-624A-40C5-B63A-AB880E0300D1
##      scientificname authority    rank  status
## 1 Ternatea vulgaris    Kuntze Species synonym
##                             valid_guid        valid_name valid_authority
## 1 7B5F817E-D94C-4929-956A-0ED57C94D3A0 Clitoria ternatea              L.
##   kingdom phylum class order family genus
## 1    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
##                                                                                                                                                                                                                   citation
## 1 ILDIS World Database of Legumes  2010. (copyright © ILDIS). Ternatea vulgaris Kuntze. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=67C3CC9C-624A-40C5-B63A-AB880E0300D1
##   match_type
## 1      exact
```

Get PESI scientific names from GUIDs


```r
pesi_name_scientific(guid='67C3CC9C-624A-40C5-B63A-AB880E0300D1')
```

```
## [1] "Ternatea vulgaris"
```

Get PESI synonyms from GUIDs


```r
head( pesi_synonyms(guid='A0433E13-D7B5-49F2-86BA-A1777364C559') )
```

```
##                                  input
## 1 A0433E13-D7B5-49F2-86BA-A1777364C559
## 2 A0433E13-D7B5-49F2-86BA-A1777364C559
## 3 A0433E13-D7B5-49F2-86BA-A1777364C559
## 4 A0433E13-D7B5-49F2-86BA-A1777364C559
## 5 A0433E13-D7B5-49F2-86BA-A1777364C559
## 6 A0433E13-D7B5-49F2-86BA-A1777364C559
##                                   GUID
## 1 757B4430-51D9-4ABB-A2FF-CA18CA04AB05
## 2 74F210C9-4F53-4972-8885-E431BCBA3D07
## 3 8E7A5C45-4F19-4E12-9FC0-00664BF7BD17
## 4 E2B240D2-B3CA-4E63-8607-914239080259
## 5 0968760E-A9CD-4DD8-B3B2-427438568862
## 6 F6834328-FB47-492F-BA46-B621C19B4804
##                                                                                 url
## 1 http://www.eu-nomen.eu/portal/taxon.php?GUID=757B4430-51D9-4ABB-A2FF-CA18CA04AB05
## 2 http://www.eu-nomen.eu/portal/taxon.php?GUID=74F210C9-4F53-4972-8885-E431BCBA3D07
## 3 http://www.eu-nomen.eu/portal/taxon.php?GUID=8E7A5C45-4F19-4E12-9FC0-00664BF7BD17
## 4 http://www.eu-nomen.eu/portal/taxon.php?GUID=E2B240D2-B3CA-4E63-8607-914239080259
## 5 http://www.eu-nomen.eu/portal/taxon.php?GUID=0968760E-A9CD-4DD8-B3B2-427438568862
## 6 http://www.eu-nomen.eu/portal/taxon.php?GUID=F6834328-FB47-492F-BA46-B621C19B4804
##               scientificname              authority    rank  status
## 1         Charybdis maritima             (L.) Speta Species synonym
## 2 Ornithogalum anthericoides (Poir.) Link ex Steud. Species synonym
## 3     Ornithogalum maritimum              (L.) Lam. Species synonym
## 4       Ornithogalum squilla              Ker Gawl. Species synonym
## 5       Scilla anthericoides                  Poir. Species synonym
## 6          Scilla lanceolata                   Viv. Species synonym
##                             valid_guid      valid_name valid_authority
## 1 A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima     (L.) Stearn
## 2 A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima     (L.) Stearn
## 3 A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima     (L.) Stearn
## 4 A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima     (L.) Stearn
## 5 A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima     (L.) Stearn
## 6 A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima     (L.) Stearn
##   kingdom phylum class order family genus
## 1    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
## 2    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
## 3    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
## 4    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
## 5    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
## 6    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
##                                                                                                                                                                                                                                                                                                        citation
## 1                     World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Charybdis maritima (L.) Speta. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=757B4430-51D9-4ABB-A2FF-CA18CA04AB05
## 2 World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Ornithogalum anthericoides (Poir.) Link ex Steud.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=74F210C9-4F53-4972-8885-E431BCBA3D07
## 3                  World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Ornithogalum maritimum (L.) Lam.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=8E7A5C45-4F19-4E12-9FC0-00664BF7BD17
## 4                    World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Ornithogalum squilla Ker Gawl.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=E2B240D2-B3CA-4E63-8607-914239080259
## 5                        World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Scilla anthericoides Poir.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=0968760E-A9CD-4DD8-B3B2-427438568862
## 6                            World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Scilla lanceolata Viv.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=F6834328-FB47-492F-BA46-B621C19B4804
##   match_type
## 1      exact
## 2      exact
## 3      exact
## 4      exact
## 5      exact
## 6      exact
```

### Mycobank

Search for a _Candida boidinii_


```r
myco_search(filter='Name CONTAINS "Candida boidinii"')
```

```
##               name  epithet    authors nameyear mycobanknr
## 1 Candida boidinii boidinii C. Ramírez     1953     344025
## 2 Candida boidinii boidinii C. Ramírez     1954     294021
##   literatureremarks literaturereferencetype literaturepagenr
## 1                NA                      NA              251
## 2                NA                      NA              100
##   description_pt   gender
## 1             NA Feminine
## 2             NA Feminine
##                                                                               e3787
## 1 Candida boidinii C. Ramírez, Microbiología Española 6 (3): 251 (1953) [MB#344025]
## 2                 Candida boidinii C. Ramírez, Revue Mycol.: 100 (1954) [MB#294021]
##                                       wikipedia
## 1 http://en.wikipedia.org/wiki/Candida boidinii
## 2 http://en.wikipedia.org/wiki/Candida boidinii
##                                          wikispecies
## 1 http://species.wikipedia.org/wiki/Candida boidinii
## 2 http://species.wikipedia.org/wiki/Candida boidinii
##                                            wikimedia
## 1 http://commons.wikipedia.org/wiki/Candida boidinii
## 2 http://commons.wikipedia.org/wiki/Candida boidinii
##                                            google
## 1 http://www.google.com/search?q=Candida boidinii
## 2 http://www.google.com/search?q=Candida boidinii
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/taxizesoap/issues).
* License: MIT
* Get citation information for `taxizesoap` in R doing `citation(package = 'taxizesoap')`

[![ropensci](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
