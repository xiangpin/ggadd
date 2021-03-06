% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/position_jitterx.R
\name{position_jitterx}
\alias{position_jitterx}
\title{Jitter points to avoid overplotting, and the whole points can be shifted vertically or horizontally}
\usage{
position_jitterx(
  width = NULL,
  height = NULL,
  hexpand = NA,
  vexpand = NA,
  seed = NA
)
}
\arguments{
\item{width, height}{Amount of vertical and horizontal jitter. The jitter
is added in both positive and negative directions, so the total spread
is twice the value specified here.

If omitted, defaults to 40\% of the resolution of the data: this means the
jitter values will occupy 80\% of the implied bins. Categorical data
is aligned on the integers, so a width or height of 0.5 will spread the
data so it's not possible to see the distinction between the categories.}

\item{hexpand, vexpand}{The distance to be shifted vertically or horizontally,
default is NA.}

\item{seed}{A random seed to make the jitter reproducible.
Useful if you need to apply the same jitter twice, e.g., for a point and
a corresponding label.
The random seed is reset after jittering.
If \code{NA} (the default value), the seed is initialised with a random value;
this makes sure that two subsequent calls start with a different seed.
Use \code{NULL} to use the current random seed and also avoid resetting}
}
\description{
This is the extension of 'position_jitter' of ggplot2, points are randomly shifted
up and down and/or left and right. In addition, the whole points layer can be shifted
by the 'hexpand' or 'vexpand' parameter. Counterintuitively adding random noise to a
plot can sometimes make it easier to read. Jittering is particularly useful for small
datasets with at least one discrete position.
}
\examples{
library(ggtree)
library(treeio)
library(ggplot2)
set.seed(1024)
tr <- rtree(10)

df <- data.frame(id=tr$tip.label, group=rep(c("A", "B"),5))
dat <- data.frame(id=rep(tr$tip.label, 8), value=rnorm(80, 0.5, 0.15))
dt <- merge(dat, df, by.x="id", by.y="id")
p1 <- ggtree(tr) \%<+\% df +
      geom_tiplab(
          align=TRUE,
          linesize=.1,
          size=3
      ) 

gf1 <- geom_fruit(data=dat,
                  geom=geom_boxplot,
                  mapping=aes(x=value, y=id),
                  orientation="y",
                  offset=0.1,
                  pwidth=0.9

         )
set.seed(1024)
gf2 <- geom_fruit(
          data=dat,
          geom=geom_point,
          mapping=aes(x=value, y=id, color=group),
          offset=0.1,
          pwidth=0.9,
          position= position_jitterx(height=0.3),
          axis.params=list(axis="x", text.size=2),
          grid.params=list()
          )

p2 <- p1 + geom_fruit_list(gf1, gf2)
p2
}
