% Generated by roxygen2 (4.0.2): do not edit by hand
\name{get_pesiid}
\alias{get_pesiid}
\title{Get the PESI id for a search term.}
\usage{
get_pesiid(searchterm, searchtype = "scientific", accepted = TRUE,
  ask = TRUE, verbose = TRUE)
}
\arguments{
\item{searchterm}{character; A vector of common or scientific names.}

\item{searchtype}{character; One of 'scientific' or 'common', or any unique abbreviation}

\item{accepted}{logical; If TRUE (default), removes names that are not accepted valid names
by PESI. Set to FALSE to give back both accepted and unaccepted names.}

\item{ask}{logical; should get_tsn be run in interactive mode?
If TRUE and more than one TSN is found for teh species, the user is asked for
input. If FALSE NA is returned for multiple matches.}

\item{verbose}{logical; should progress be printed?}
}
\value{
A vector of PESI ids. If a taxon is not found NA is given. If more than one PESI
   id is found the function asks for user input (if ask = TRUE), otherwise returns NA.
   Comes with an attribute \emph{match} to investigate the reason for NA (either 'not found',
   'found' or if ask = FALSE 'multi match')
}
\description{
Retrieve the PESI id of a taxon.
}
\examples{
\dontrun{
get_pesiid(searchterm = "Salvelinus")
get_pesiid(c("Salvelinus fontinalis","Pomacentrus brachialis"))
splist <- c("Salvelinus fontinalis", 'Pomacentrus brachialis', "Leptocottus armatus",
  	"Clinocottus recalvus", "Trachurus trachurus", "Harengula clupeola")
get_pesiid(splist, verbose=FALSE)

# When not found
get_pesiid(searchterm="howdy")
get_pesiid(c("Salvelinus fontinalis", "howdy"))

# Using common names
get_pesiid(searchterm="salmon", searchtype="common")
get_pesiid(searchterm="great white shark", searchtype="common")
}
}
\seealso{
\code{\link[taxizesoap]{classification_s}}
}

