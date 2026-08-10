#' @title Définir les valeurs des seuils
#'
#' @param test_name Chaîne de caractères. Le nom du test à mettre à jour.
#' @param thresholds Vecteur numérique nommé. Les valeurs supérieures de chaque
#'   seuil d'un test.
#'
#' @returns Renvoie de manière invisible la liste de tous les seuils
#' actuellement en vigueur (donc mis à jour). C'est une liste d'item avec les
#' différentes modalités ("Good", "Uncertain", "Bad", "Severe", "Poor"...) et
#' leur seuils associés.
#'
#' @details
#' Si \code{test_name} est manquant, l'argument \code{thresholds} n'est pas
#' utilisé et tous les seuils seront réinitialisés à leurs valeurs par défaut.
#'
#' Si \code{test_name} est fourni mais que l'argument \code{thresholds} est
#' manquant, seuls les seuils du test \code{test_name} seront réinitialisés
#' à leurs valeurs par défaut.
#'
#' Enfin, si \code{test_name} et \code{thresholds} sont tous deux fournis,
#' seuls les seuils du test \code{test_name} seront mis à jour avec les valeurs
#' spécifiées dans \code{thresholds}.
#'
#' Cette fonction met à jour l'option `rjd3qr.thresholds`.
#'
#' @examples
#'
#' # Définir les seuils pour le test "m7"
#' set_thresholds(
#'     test_name = "m7",
#'     thresholds = c(Bon = 0.8, Mauvais = 1.4, Sévère = Inf)
#' )
#'
#' # Réinitialiser les seuils du test "oos_mean" à leurs valeurs par défaut
#' set_thresholds(test_name = "oos_mean")
#'
#' # Réinitialiser tous les seuils à leurs valeurs par défaut
#' set_thresholds()
#'
#' @keywords internal
#' @name fr-set_thresholds
NULL
#> NULL

#' @title Set values for thresholds
#'
#' @param test_name String. The name of the test to update.
#' @param thresholds Named vector of numerics. The upper values of
#' each break of a threshold.
#'
#' @returns Returns invisibly all the current (updated) thresholds. It's a list
#' of item with grade ("Good", "Uncertain", "Bad", "Severe", "Poor"...).
#'
#' @details
#' If \code{test_name} is missing, the argument \code{thresholds} is not used
#' and all thresholds will be updated to their default values.
#'
#' If \code{test_name} is not missing, but if the argument \code{thresholds} is
#' missing then only the thresholds of the test \code{test_name} will be updated
#' to its default values.
#'
#' Finally, if \code{test_name} and \code{thresholds} are not missing, then only
#' the thresholds of the test \code{test_name} are updated with the value
#' \code{thresholds}.
#'
#' This function updates the option `rjd3qr.thresholds`.
#'
#' @examples
#'
#' # Set "m7"
#' set_thresholds(
#'     test_name = "m7",
#'     thresholds = c(Good = 0.8, Bad = 1.4, Severe = Inf)
#' )
#'
#' # Set "oos_mean" to default
#' set_thresholds(test_name = "oos_mean")
#'
#' # Set all thresholds to default
#' set_thresholds()
#' @export
#'
#' @seealso [Traduction française][fr-set_thresholds()]
set_thresholds <- function(test_name, thresholds) {
    default_thresholds <- get_thresholds(default = TRUE)
    if (missing(test_name)) {
        all_thresholds <- default_thresholds
    } else {
        all_thresholds <- get_thresholds(default = FALSE)
        if (missing(thresholds)) {
            all_thresholds[[test_name]] <- default_thresholds[[test_name]]
        } else {
            all_thresholds[[test_name]] <- thresholds
        }
    }
    options(rjd3qr.thresholds = all_thresholds)
    return(invisible(all_thresholds))
}

#' @title Obtenir tous les seuils (par défaut)
#'
#' @param test_name Chaîne de caractères. Le nom du test pour lequel obtenir
#'   les seuils.
#' @param default Booléen. (par défaut, TRUE)
#'   Si TRUE, les seuils par défaut seront retournés.
#'   Si FALSE, les seuils actuellement utilisés seront retournés.
#'
#' @returns Renvoie de manière invisible les seuils de `test_name`. Si
#' `test_name` est manquant, la fonction retourne tous les seuils.
#'
#' @details
#' Si \code{test_name} est manquant, tous les seuils seront retournés.
#'
#' Les seuils sont lus depuis l'option `rjd3qr.thresholds`.
#'
#' @examples
#'
#' # Obtenir tous les seuils par défaut
#' get_thresholds(default = TRUE)
#'
#' # Obtenir tous les seuils actuellement utilisés
#' get_thresholds(default = FALSE)
#'
#' # Obtenir les seuils actuellement utilisés pour le test "oos_mean"
#' get_thresholds(test_name = "oos_mean", default = FALSE)
#'
#' @keywords internal
#' @name fr-get_thresholds
NULL
#> NULL

#' @title Get all (default) thresholds
#'
#' @param test_name String. The name of the test to get.
#' @param default Boolean. (default is TRUE)
#' If TRUE, the default threshold will be returned.
#' If FALSE the current used thresholds.
#'
#' @returns Returns invisibly the thresholds of the chosen item. If test_name
#' is missing, it returns all the current thresholds.
#'
#' @details
#' If \code{test_name} is missing, all threshold will be returned.
#'
#' The thresholds are read from the option `rjd3qr.thresholds`.
#'
#' @examples
#'
#' # Get all default thresholds
#' get_thresholds(default = TRUE)
#'
#' # Get all current thresholds
#' get_thresholds(default = FALSE)
#'
#' # Get all current thresholds
#' get_thresholds(test_name = "oos_mean", default = FALSE)
#' @export
#'
#' @seealso [Traduction française][fr-get_thresholds()]
get_thresholds <- function(test_name, default = TRUE) {
    def1 <- c(Severe = 0.001, Bad = 0.01, Uncertain = 0.05, Good = Inf)
    def2 <- c(Bad = 0.01, Uncertain = 0.1, Good = Inf)
    def3 <- c(Good = 1., Bad = 2., Severe = Inf)
    def4 <- c(Good = 1., Bad = Inf)
    def5 <- c(Good = 3., Uncertain = 5., Bad = Inf)
    def6 <- c(Good = 0., Uncertain = 1., Bad = 3., Severe = 5.)

    default_thresholds <- list(
        qs_residual_s_on_sa = def1,
        qs_residual_sa_on_i = def1,

        f_residual_s_on_sa = def1,
        f_residual_sa_on_i = def1,

        f_residual_td_on_sa = def1,
        f_residual_td_on_i = def1,

        residuals_independency = def2,
        residuals_homoskedasticity = def2,

        residuals_skewness = def2,
        residuals_kurtosis = def2,
        residuals_normality = def2,

        oos_mean = def2,
        oos_mse = def2,

        m7 = def3,
        q = def4,
        q_m2 = def4,
        pct_outliers = def5,

        grade = def6
    )

    if (default) {
        thresholds <- default_thresholds
    } else {
        thresholds <- getOption("rjd3qr.thresholds")
    }

    if (missing(test_name)) {
        return(thresholds)
    } else {
        return(thresholds[[test_name]])
    }
}
