```r
> install.packages("DBI")
> library(DBI)
> install.packages("RSQLite")
> library(RSQLite)
> connection <- dbConnect(RSQLite::SQLite(), "/cloud/project/database.sqlite")
> query <- dbSendQuery(connection, "SELECT Name as Author FROM Authors ORDER BY Name")
> result <- dbFetch(query, n=10)
> result
               Author
1       ABHISEK KUNDU
2      Aaditya Ramdas
3  Aaron C. Courville
4         Aaron Klein
5          Aaron Roth
6         Aarti Singh
7   Abbas Abdolmaleki
8  Abhradeep Thakurta
9          Adam Smith
10      Adarsh Prasad
> dbClearResult(query)
```
--------------------

1. Назва статті (Title), тип виступу (EventType). Необхідно вибрати тільки статті
с типом виступу Spotlight. Сортування по назві статті.
```r
> query <- dbSendQuery(connection, "SELECT Title, EventType FROM Papers WHERE EventType='Spotlight' ORDER BY Title")
> result <- dbFetch(query, n=10)
> result
                                                                                          Title
1  A Tractable Approximation to Optimal Point Process Filtering: Application to Neural Encoding
2                                    Accelerated Mirror Descent in Continuous and Discrete Time
3                        Action-Conditional Video Prediction using Deep Networks in Atari Games
4                                                                      Adaptive Online Learning
5                          Asynchronous Parallel Stochastic Gradient for Nonconvex Optimization
6                                                 Attention-Based Models for Speech Recognition
7                                                       Automatic Variational Inference in Stan
8                                   Backpropagation for Energy-Efficient Neuromorphic Computing
9                       Bandit Smooth Convex Optimization: Improving the Bias-Variance Tradeoff
10                         Biologically Inspired Dynamic Textures for Probing Motion Perception
   EventType
1  Spotlight
2  Spotlight
3  Spotlight
4  Spotlight
5  Spotlight
6  Spotlight
7  Spotlight
8  Spotlight
9  Spotlight
10 Spotlight
> dbClearResult(query)
```

--------------------

2. Ім’я автора (Name), Назва статті (Title). Необхідно вивести всі назви статей
для автора «Josh Tenenbaum». Сортування по назві статті.
```r
> query <- dbSendQuery(connection, "SELECT a.Name, p.Title FROM Authors a, Papers p WHERE a.Name='Josh Tenenbaum' ORDER BY Title")
> result <- dbFetch(query, n=10)
> result
             Name
1  Josh Tenenbaum
2  Josh Tenenbaum
3  Josh Tenenbaum
4  Josh Tenenbaum
5  Josh Tenenbaum
6  Josh Tenenbaum
7  Josh Tenenbaum
8  Josh Tenenbaum
9  Josh Tenenbaum
10 Josh Tenenbaum
                                                                                                                        Title
1                                                                     3D Object Proposals for Accurate Object Class Detection
2                                                  A Bayesian Framework for Modeling Confidence in Perceptual Decision Making
3                                                                              A Complete Recipe for Stochastic Gradient MCMC
4  A Convergent Gradient Descent Algorithm for Rank Minimization and Semidefinite Programming from Random Linear Measurements
5                                              A Dual Augmented Block Minimization Framework for Learning with Limited Memory
6                A Framework for Individualizing Predictions of Disease Trajectories by Exploiting Multi-Resolution Structure
7                                                            A Gaussian Process Model of Quasar Spectral Energy Distributions
8                             A Generalization of Submodular Cover via the Diminishing Return Property on the Integer Lattice
9                                                                               A Market Framework for Eliciting Private Data
10                                                          A Nonconvex Optimization Framework for Low Rank Matrix Estimation
> dbClearResult(query)
```
--------------------

3. Вибрати всі назви статей (Title), в яких є слово «statistical». Сортування по
назві статті.
```r
query <- dbSendQuery(connection, "SELECT Title FROM Papers WHERE Title LIKE '%statistical%' ORDER BY Title")
result <- dbFetch(query, n=10)
result
                                                                                 Title
1 Adaptive Primal-Dual Splitting Methods for Statistical Learning and Image Processing
2                                Evaluating the statistical significance of biclusters
3                  Fast Randomized Kernel Ridge Regression with Statistical Guarantees
4     High Dimensional EM Algorithm: Statistical Optimization and Asymptotic Normality
5                Non-convex Statistical Optimization for Sparse Tensor Graphical Model
6            Regularized EM Algorithms: A Unified Framework and Statistical Guarantees
7                            Statistical Model Criticism using Kernel Two Sample Tests
8                         Statistical Topological Data Analysis - A Kernel Perspective
dbClearResult(query)
```

--------------------

4. Ім’я автору (Name), кількість статей по кожному автору (NumPapers).
Сортування по кількості статей від більшої кількості до меньшої.
```r
> query <- dbSendQuery(connection, "SELECT Authors.Name, COUNT(PaperAuthors.Id) AS NumPapers FROM Authors INNER JOIN PaperAuthors ON Authors.Id = PaperAuthors.AuthorId GROUP BY Authors.Name ORDER BY NumPapers desc")
> result <- dbFetch(query, n=10)
> result
                   Name NumPapers
1  Pradeep K. Ravikumar         7
2        Lawrence Carin         6
3               Han Liu         6
4     Zoubin Ghahramani         5
5               Le Song         5
6   Inderjit S. Dhillon         5
7          Zhaoran Wang         4
8         Yoshua Bengio         4
9  Simon Lacoste-Julien         4
10          Shie Mannor         4
dbClearResult(query)
dbDisconnect(connection)
```