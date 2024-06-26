% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mvsusie.R, R/mvsusie_rss.R, R/mvsusie_ss.R
\name{mvsusie}
\alias{mvsusie}
\alias{mvsusie_rss}
\alias{mvsusie_suff_stat}
\title{Multivariate SUm of Single Effect (SuSiE) Regression}
\usage{
mvsusie(
  X,
  Y,
  L = 10,
  prior_variance = 0.2,
  residual_variance = NULL,
  prior_weights = NULL,
  standardize = TRUE,
  intercept = TRUE,
  approximate = FALSE,
  estimate_residual_variance = FALSE,
  estimate_prior_variance = TRUE,
  estimate_prior_method = "EM",
  check_null_threshold = 0,
  prior_tol = 1e-09,
  compute_objective = TRUE,
  s_init = NULL,
  coverage = 0.95,
  min_abs_corr = 0.5,
  compute_univariate_zscore = FALSE,
  precompute_covariances = FALSE,
  n_thread = 1,
  max_iter = 100,
  tol = 0.001,
  verbosity = 2,
  track_fit = FALSE
)

mvsusie_rss(
  Z,
  R,
  N,
  Bhat,
  Shat,
  varY,
  prior_variance = 0.2,
  residual_variance = NULL,
  ...
)

mvsusie_suff_stat(
  XtX,
  XtY,
  YtY,
  N,
  L = 10,
  X_colmeans = NULL,
  Y_colmeans = NULL,
  prior_variance = 0.2,
  residual_variance = NULL,
  prior_weights = NULL,
  standardize = TRUE,
  estimate_residual_variance = FALSE,
  estimate_prior_variance = TRUE,
  estimate_prior_method = "EM",
  check_null_threshold = 0,
  prior_tol = 1e-09,
  compute_objective = TRUE,
  precompute_covariances = FALSE,
  s_init = NULL,
  coverage = 0.95,
  min_abs_corr = 0.5,
  n_thread = 1,
  max_iter = 100,
  tol = 0.001,
  verbosity = 2,
  track_fit = FALSE
)
}
\arguments{
\item{X}{N by J matrix of covariates.}

\item{Y}{Vector of length N, or N by R matrix of response
variables.}

\item{L}{Maximum number of non-zero effects.}

\item{prior_variance}{Can be either (1) a vector of length L, or a
scalar, for scaled prior variance when Y is univariate (which
should then be equivalent to \code{\link[susieR]{susie}}); or (2) a
matrix for a simple multivariate regression; or (3) a mixture prior
from \code{\link{create_mixture_prior}}.}

\item{residual_variance}{The residual variance}

\item{prior_weights}{A vector of length p giving the prior
probability that each element is non-zero. Note that the prior
weights need to be non-negative but do not need to sum to 1; they
will automatically be normalized to sum to 1 so that they represent
probabilities. The default setting is that the prior weights are
the same for all variables.}

\item{standardize}{Logical flag specifying whether to standardize
columns of X to unit variance prior to fitting. If you do not
standardize you may need to think more carefully about specifying
the scale of the prior variance. Whatever the value of standardize,
the coefficients (returned by \code{\link{coef}}) are for X
on the original input scale. Note that any column of X with zero
variance is not standardized, but left as is.}

\item{intercept}{Should intercept be fitted or set to zero. Setting
\code{intercept = FALSE} is generally not recommended.}

\item{approximate}{Specifies whether to use approximate computation
for the intercept when there are missing values in Y. The
approximation saves some computational effort. Note that when the
residual_variance is a diagonal matrix, running \code{mvsusie} with
\code{approximate = TRUE} will give same result as
\code{approximate = FALSE}, but with less running time. This
setting is only relevant when there are missing values in Y and
\code{intercept} = TRUE.}

\item{estimate_residual_variance}{When
\code{estimate_residual_variance = TRUE}, the residual variance is
estimated; otherwise it is fixed. Currently
\code{estimate_residual_variance = TRUE} only works for univariate Y.}

\item{estimate_prior_variance}{When \code{estimate_prior_variance =
TRUE}, the prior variance is estimated; otherwise it is
fixed. Currently \code{estimate_prior_variance = TRUE} only works
for univariate Y, or for multivariate Y when the prior variance is
a matrix).}

\item{estimate_prior_method}{The method used for estimating the
prior variance; valid choices are \code{"optim"}, \code{"uniroot"}
or \code{"em"} for univariate Y; and \code{"optim"},
\code{"simple"} for multivariate Y.}

\item{check_null_threshold}{When the prior variance is estimated,
the estimate is compared against the null, and the prior variance
is set to zero unless the log-likelihood using the estimate is
larger than that of null by this threshold. For example, setting
\code{check_null_threshold = 0.1} will \dQuote{nudge} the estimate
towards zero. When used with \code{estimate_prior_method = "EM"},
setting \code{check_null_threshold = NA} will skip this check.}

\item{prior_tol}{When the prior variance is estimated, compare the
estimated value to this value at the end of the analysis and
exclude a single effect from PIP computation if the estimated prior
variance is smaller than it.}

\item{compute_objective}{Add description of "compute_objective"
input argument here.}

\item{s_init}{A previous model fit with which to initialize.}

\item{coverage}{Coverage of credible sets.}

\item{min_abs_corr}{Minimum of absolute value of correlation
allowed in a credible set. The setting \code{min_abs_corr = 0.5}
corresponds to squared correlation of 0.25, which is a commonly
used threshold for genotype data in genetics studies.}

\item{compute_univariate_zscore}{When
\code{compute_univariate_zscore = TRUE}, the z-scores from the
per-variable univariate regressions are outputted. (Note that these
z-scores are not actually used to fit the multivariate susie
model.)}

\item{precompute_covariances}{If \code{precompute_covariances =
TRUE}, precomputes various covariance quantities to speed up
computations at the cost of increased memory usage.}

\item{n_thread}{Maximum number of threads to use for parallel
computation (only applicable when a mixture prior is used).}

\item{max_iter}{Maximum number of iterations to perform.}

\item{tol}{The model fitting will terminate when the increase in
ELBOs between two successive iterations is less than \code{tol}.}

\item{verbosity}{Set \code{verbosity = 0} for no messages;
\code{verbosity = 1} for a progress bar; and \code{verbosity = 2}
for more detailed information about the algorithm's progress at the
end of each iteration.}

\item{track_fit}{Add attribute \code{trace} to the return value
which records the algorithm's progress at each iteration.}

\item{Z}{J x R matrix of z-scores.}

\item{R}{J x J LD matrix.}

\item{N}{The sample size.}

\item{Bhat}{Alternative summary data giving the estimated effects
(J X R matrix). This, together with \code{Shat}, may be
provided instead of \code{Z}.}

\item{Shat}{Alternative summary data giving the standard errors of
the estimated effects (J X R matrix). This, together with
\code{Bhat}, may be provided instead of \code{Z}.}

\item{varY}{The sample covariance of Y, defined as \eqn{Y'Y/(N-1)}.
When the sample covariance is not provided, the coefficients
(returned from \code{coef}) are computed on the
\dQuote{standardized} X, y scale.}

\item{\dots}{Additional arguments passed to
\code{\link{mvsusie_suff_stat}}.}

\item{XtX}{A J x J matrix \eqn{X^TX} in which the columns of \eqn{X}
are centered to have mean zero.}

\item{XtY}{A J x R matrix \eqn{X^TY} in which the columns of
\eqn{X} and \eqn{Y} are centered to have mean zero.}

\item{YtY}{An R x R matrix \eqn{Y^TY} in which the columns of
\eqn{Y} are centered to have mean zero.}

\item{X_colmeans}{A vector of length J giving the column means of
\eqn{X}. If it is provided with \code{Y_colmeans}, the intercept is
estimated; otherwise, the intercept is \code{NA}.}

\item{Y_colmeans}{A vector of length R giving the column means of
\eqn{Y}. If it is provided with \code{X_colmeans}, the intercept is
  estimated; otherwise, the intercept is \code{NA}.}
}
\value{
A multivariate susie fit, which is a list with some or all
of the following elements:

\item{alpha}{L by p matrix of posterior inclusion probabilites.}

\item{b1}{L by p matrix of posterior mean single-effect estimates.}

\item{b1_rescaled}{L by p matrix} of posterior mean single-effect
  estimates on the original input scale (same as \code{coef}).

\item{b2}{L by p matrix of posterior second moments.}

\item{KL}{Vector of single-effect KL divergences.}

\item{lbf}{Vector of single-effect log-Bayes factors.}

\item{sigma2}{Residual variance.}

\item{V}{Prior variance.}

\item{elbo}{Vector storing the the evidence lower bound, or
  \dQuote{ELBO}, achieved at each iteration of the model fitting
  algorithm, which attempts to maximize the ELBO.}

\item{niter}{Number of iterations performed.}

\item{convergence}{Convergence status.}

\item{sets}{Estimated credible sets.}

\item{pip}{Vector of posterior inclusion probabilities.}

\item{walltime}{Records runtime of the model fitting algorithm.}

\item{z}{Vector of univariate z-scores.}

\item{single_effect_lfsr}{Average lfsr (local false sign rate) for
  each CS.}

\item{lfsr}{TO DO: Explain what this output is.}

\item{conditional_lfsr}{The lfsr (local false sign rate) given that
  the variable is the single effect.}
}
\description{
Performs a Bayesian multiple linear regression of Y on X.
  That is, this function fits the regression model \deqn{Y = \sum_l X
  b_l + e,} where the elements of \eqn{e} are \emph{i.i.d.} normal
  with zero mean and variance \code{residual_variance}, and the sum
  \eqn{\sum_l b_l} is a vector of p effects to be estimated. The
  SuSiE assumption is that each \eqn{b_l} has exactly one non-zero
  element.
}
\examples{
# Example with one response.
set.seed(1)
n <- 2000
p <- 1000
beta <- rep(0, p)
beta[1:4] <- 1
X <- matrix(rnorm(n * p), n, p)
Y <- X \%*\% beta + rnorm(n)
fit <- mvsusie(X, Y, L = 10)

# Sufficient statistics example with one response.
X_colmeans <- colMeans(X)
Y_colmeans <- colMeans(Y)
X <- scale(X, center = TRUE, scale = FALSE)
Y <- scale(Y, center = TRUE, scale = FALSE)
XtX <- crossprod(X)
XtY <- crossprod(X, Y)
YtY <- crossprod(Y)
res <- mvsusie_suff_stat(XtX, XtY, YtY, n, L = 10, X_colmeans, Y_colmeans)

# RSS example with one response.
R <- crossprod(X)
z <- susieR:::calc_z(X, Y)
res <- mvsusie_rss(z, R, N = n, L = 10)

# Example with three responses.
set.seed(1)
n <- 500
p <- 1000
true_eff <- 2
X <- sample(c(0, 1, 2), size = n * p, replace = TRUE)
X <- matrix(X, n, p)
beta1 <- rep(0, p)
beta2 <- rep(0, p)
beta3 <- rep(0, p)
beta1[1:true_eff] <- runif(true_eff)
beta2[1:true_eff] <- runif(true_eff)
beta3[1:true_eff] <- runif(true_eff)
y1 <- X \%*\% beta1 + rnorm(n)
y2 <- X \%*\% beta2 + rnorm(n)
y3 <- X \%*\% beta3 + rnorm(n)
Y <- cbind(y1, y2, y3)
prior <- create_mixture_prior(R = 3)
fit <- mvsusie(X, Y, prior_variance = prior)

# Sufficient statistics example with three responses.
X_colmeans <- colMeans(X)
Y_colmeans <- colMeans(Y)
X <- scale(X, center = TRUE, scale = FALSE)
Y <- scale(Y, center = TRUE, scale = FALSE)
XtX <- crossprod(X)
XtY <- crossprod(X, Y)
YtY <- crossprod(Y)
res <- mvsusie_suff_stat(XtX, XtY, YtY, n,
  L = 10, X_colmeans, Y_colmeans,
  prior_variance = prior
)

# RSS example with three responses.
R <- crossprod(X)
Z <- susieR:::calc_z(X, Y)
res <- mvsusie_rss(Z, R, N = n, L = 10, prior_variance = prior)

}
