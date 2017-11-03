if (!require(gmnl)) install.packages("gmnl"); require(gmnl)
if (!require(mlogit)) install.packages("mlogit"); require(mlogit)
if (!require(foreign)) install.packages("foreign"); require(foreign)

contrato = read.dta("/home/hector/GoogleDrivePersonal/Research/Papers in progress/Article - Agricultura de Contrato/baseChoice.dta")

cn = mlogit.data(contrato, choice = "choice", id.var = "id", shape = "long", 
                 alt.var = "contract")

mixl = gmnl(choice~nooption+F11+F12+F13+F21+F22+F23+F31+F32+F33+F41+F42+F43|0, 
            data = cn, model = "mixl", panel = TRUE, R=100,
            ranp = c(F11 = "n", F12="n", F13 = "n",
                     F21 = "n", F22 = "n", F23 = "n",
                     F31 = "n", F32 = "n", F33 = "n", 
                     F41 = "n", F42 = "n", F43 = "n"),
            correlation = FALSE)

plot(mixl, par = "F11", effect = "ce", type = "density", col = "grey")
plot(mixl, par = "F41", effect = "ce", type = "density", col = "grey")

plot(mixl, par = "F33", effect = "ce", ind = TRUE, id = 1:10)

individual = effect.gmnl(mixl, par = "F33", effect = "ce")


mixl = gmnl(choice~nooption+F11+F12+F13+F21+F22+F23+F31+F32+F33+F41+F42+F43|0, 
            data = cn, model = "mixl", panel = TRUE, R=10,
            ranp = c(nooption= "n", F11 = "n", F12="n", F13 = "n",
                     F21 = "n", F22 = "n", F23 = "n",
                     F31 = "n", F32 = "n", F33 = "n", 
                     F41 = "n", F42 = "n", F43 = "n"),
            correlation = FALSE)

vcov(mixl, what = 'ranp', type = 'cov', se='true')
vcov(mixl, what = 'ranp', type = 'sd', se = 'true')
vcov(mixl, what = 'ranp', type = 'cor')

gmnl_model = gmnl(choice~nooption+F11+F12+F13+F21+F22+F23+F31+F32+F33+F41+F42+F43|0, 
                  data = cn, model = "gmnl", panel = TRUE, R=100,
                  ranp = c(F11 = "n", F12="n", F13 = "n",
                           F21 = "n", F22 = "n", F23 = "n",
                           F31 = "n", F32 = "n", F33 = "n", 
                           F41 = "n", F42 = "n", F43 = "n"),
                  correlation = FALSE)


gmnl_model = gmnl(choice~nooption+F11+F12+F13+F21+F22+F23+F31+F32+F33+F41+F42+F43|0, 
                  data = cn, model = "gmnl", panel = TRUE, R=100,
                  ranp = c(F11 = "n", F12="n", F13 = "n",
                           F21 = "n", F22 = "n", F23 = "n",
                           F31 = "n", F32 = "n", F33 = "n", 
                           F41 = "n", F42 = "n", F43 = "n"),
                  correlation = FALSE, init.gamma = 0)