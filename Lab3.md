```r
> install.packages("rvest")
> library('rvest')
> library('xml2')
> html <- read_html("http://www.imdb.com/search/title?count=100&release_date=2017,2017&title_type=feature")
> install.packages('selectr')
> rank_html <- rvest::html_nodes(html,'.text-primary')
> rank_data <- rvest::html_text(html)
> rank_data <- as.numeric(rank_data)
> title_html <- html_nodes(html,'.lister-item-header a')
> title_data <- html_text(title_html)
> runtime_html <- html_nodes(html,'.text-muted .runtime')
> runtime_data <- html_text(runtime_html)
> runtime_data <- gsub(" min", "", runtime_data)
> runtime_data <- as.numeric(runtime_data)
> movies <- data.frame(Rank = rank_data, Title = title_data, Runtime = runtime_data, stringsAsFactors = FALSE)
```

---------------------

1. Виведіть перші 6 назв фільмів дата фрейму
```r
> head(movies$Title, 6)
[1] "Blade Runner 2049"            "Molly's Game"                
[3] "Thor: Ragnarok"               "Call Me by Your Name"        
[5] "The Killing of a Sacred Deer" "It"  
```
---------------------

2. Виведіть всі назви фільмів с тривалістю більше 120 хв.
```r                        
> movies[movies$Runtime > 120, ]$Title
 [1] "Blade Runner 2049"                               
 [2] "Molly's Game"                                    
 [3] "Thor: Ragnarok"                                  
 [4] "Call Me by Your Name"                            
 [5] "The Killing of a Sacred Deer"                    
 [6] "It"                                              
 [7] "Guardians of the Galaxy Vol. 2"                  
 [8] "Spider-Man: Homecoming"                          
 [9] "Star Wars: Episode VIII - The Last Jedi"         
[10] "Beauty and the Beast"                            
[11] "Pirates of the Caribbean: Dead Men Tell No Tales"
[12] "The Shape of Water"                              
[13] "Logan"                                           
[14] "Transformers: The Last Knight"                   
[15] "Valerian and the City of a Thousand Planets"     
[16] "Alien: Covenant"                                 
[17] "Wonder Woman"                                    
[18] "Kingsman: The Golden Circle"                     
[19] "John Wick: Chapter 2"                            
[20] "Mother!"                                         
[21] "Darkest Hour"                                    
[22] "Phantom Thread"                                  
[23] "King Arthur: Legend of the Sword"                
[24] "What Happened to Monday"                         
[25] "The Shack"                                       
[26] "The Upside"                                      
[27] "Papillon"                                        
[28] "The Fate of the Furious"                         
[29] "Hostiles"                                        
[30] "War for the Planet of the Apes"                  
[31] "Power Rangers"                                   
[32] "Shot Caller"                                     
[33] "Downsizing"                                      
[34] "Mudbound"                                        
[35] "All the Money in the World"    
```
---------------------

3. Скільки фільмів мають тривалість менше 100 хв.
```r                  
> length(movies[movies$Runtime < 100, ]$Title)
[1] 12
```