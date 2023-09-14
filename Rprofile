# TUNA mirror
options(repos=c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options(BioC_mirror="https://mirrors.tuna.tsinghua.edu.cn/bioconductor")
options(width=120)
options(menu.graphics=FALSE)

if (Sys.info()['sysname'] == "Darwin") {
    grDevices::quartz.options(width=8, height=6, pointsize=10, reset=FALSE)
    options(help_type="html")
    read.clipborad <- function() read.delim(file=pipe("pbpaste"), check.names=FALSE)
}

