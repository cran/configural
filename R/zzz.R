## Messages to be displayed when the user loads configural:
.onAttach <- function(libname, pkgname) {
    version <- read.dcf(file = system.file("DESCRIPTION", package = pkgname), fields = "Version")
    packageStartupMessage(crayon::white("----------------------------------------------------- ", crayon::bold(paste(pkgname, "version", version)), " --"))
    packageStartupMessage("\nPlease report any bugs to ", crayon::italic("github.com/bwiernik/configural/issues"), "\nor ", crayon::italic("brenton@wiernik.org"))
    packageStartupMessage("\nWe work hard to produce these open-source tools for the R community, \n",
                          "please cite configural when you use it in your research: \n",
                          "  Wiernik, B. M. (2019). \n  configural: An R package for profile analysis [R package].",
                          "\n  https://github.org/bwiernik/configural\n\n",
                          "  Wiernik, B. M., Wilmot, M. P., Davison, M. L., & Ones, D. S. (2019). \n  ",
                          crayon::italic("Meta-analytic criterion profile analysis"), ". \n",
                          "  Manuscript submitted for publication.")
    packageStartupMessage("\nFind info about configural on the web at ", crayon::italic("wiernik.org"))

    # Check if there is an internet connection. If there is, check whether the local version of configural is up to date compared to the CRAN version.
    # if(try(is.character(RCurl::getURL("http://www.r-pkg.org/badges/version/configural")), silent = TRUE) == TRUE){
    #
    #      check_version <- function(cran_version, sys_version){
    #           cran_v_char <- cran_version
    #           cran_v_num <- as.numeric(stringr::str_split(cran_v_char, "[.]")[[1]])
    #           sys_v_char <- stringr::str_split(sys_version, "[.]")[[1]]
    #           sys_v_num <- as.numeric(sys_v_char)
    #
    #           if(length(cran_v_num) == 3) cran_v_num <- c(cran_v_num, "0")
    #           if(length(sys_v_num) == 3) sys_v_num <- c(sys_v_num, "0")
    #
    #           .cran_v_num <- cran_v_num
    #           .sys_v_num <- sys_v_num
    #           desired_digits <- 4
    #           necessary_digits_cran <- desired_digits - nchar(cran_v_num)
    #           necessary_digits_sys <- desired_digits - nchar(sys_v_num)
    #           for(i in 1:length(sys_v_num)){
    #                .cran_v_num[i] <- paste0(c(rep("0", necessary_digits_cran[i]), .cran_v_num[i]), collapse = "")
    #                .sys_v_num[i] <- paste0(c(rep("0", necessary_digits_sys[i]), .sys_v_num[i]), collapse = "")
    #           }
    #
    #           .cran_v_num <- paste(.cran_v_num, collapse = "")
    #           .sys_v_num <- paste(.sys_v_num, collapse = "")
    #
    #           if(cran_v_char == sys_version){
    #                out_of_date <- FALSE
    #                ahead_of_cran <- FALSE
    #                best_version <- c(Current = cran_version)
    #           }else{
    #                best_version <- sort(c(CRAN = .cran_v_num, Local = .sys_v_num), decreasing = TRUE)[1]
    #                out_of_date <- names(best_version) == "CRAN"
    #                ahead_of_cran <- names(best_version) == "Local"
    #                if(names(best_version) == "CRAN") best_version <- c(CRAN = cran_version)
    #                if(names(best_version) == "Local") best_version <- c(Local = sys_version)
    #           }
    #
    #           vcheck_devnum <- zapsmall(as.numeric(sys_v_num[4])) > 0
    #
    #           as.data.frame(list(best_version = names(best_version),
    #                              cran_version = cran_version,
    #                              sys_version = sys_version,
    #                              out_of_date = out_of_date,
    #                              ahead_of_cran = ahead_of_cran,
    #                              development = vcheck_devnum))
    #      }
    #
    #      pkg_badge <- xml2::read_html("http://www.r-pkg.org/badges/version/configural")
    #      cran_v_char <- gsub(x = stringr::str_split(as.character(pkg_badge), "\n")[[1]][9], pattern = " ", replacement = "")
    #      vcheck <- check_version(cran_version = cran_v_char, sys_version = version)
    #
    #      use_symbols <- .support_unicode()
    #
    #      packageStartupMessage(crayon::white("\n", paste0("-----------------------------------------------------", paste0(rep_len("-", nchar(paste(pkgname, "version", version)) - 13), collapse = ""), " "), crayon::bold("Version check"), " --"))
    #      if(vcheck$best_version == "CRAN"){
    #           version_message <- "Oh no! It looks like your copy of configural is out of date!"
    #           if(use_symbols) version_message <- paste0(cli::symbol$cross, " ", version_message)
    #           packageStartupMessage(crayon::red(version_message))
    #           packageStartupMessage("No worries, it's easy to obtain the latest version - just run the following command: \n")
    #           packageStartupMessage('                       install.packages("configural")')
    #      }else if(vcheck$best_version == "Current"){
    #           version_message <- "Yay! Your copy of configural is up to date!"
    #           if(use_symbols) version_message <- paste0(cli::symbol$tick, " ", version_message)
    #           packageStartupMessage(crayon::green(version_message))
    #      }else if(vcheck$best_version == "Local"){
    #           version_message <- "Kudos! Your copy of configural is more recent than the current CRAN release!"
    #           if(use_symbols) version_message <- paste0(cli::symbol$tick, " ", version_message)
    #           packageStartupMessage(crayon::green(version_message))
    #      }
    #
    # }

    sys_v_char <- stringr::str_split(version, "[.]")[[1]]
    sys_v_num <- as.numeric(sys_v_char)
    if(length(sys_v_num) == 3) sys_v_num <- c(sys_v_num, 0)
    if(sys_v_num[4] > 0)
         packageStartupMessage(paste0("NOTE: You are currently using an UNRELEASED development build (augmentation of release v", paste(sys_v_char[1:3], collapse = "."), ")"))
}

.support_unicode <- function(override = NULL) {
    if(!is.null(override)) override else (l10n_info()$`UTF-8` | if(!is.null(.Options$cli.unicode)) isTRUE(.Options$cli.unicode) else FALSE | nzchar(Sys.getenv("RSTUDIO_USER_IDENTITY")) )
}


#' Retrieve the NEWS file for the configural package
#'
#' @description
#' This function gives a shortcut to the `utils::news(package = "configural")` function and displays configural's NEWS file, which contains version information, outlines additions and changes to the package, and describes other updates.
#'
#' @export
#'
#' @importFrom utils news
#'
#' @encoding UTF-8
#'
#' @examples
#' configural_news()
configural_news <- function(){
     news(package = "configural")
}
