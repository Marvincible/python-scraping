## Ministry of Health web service scraping

Automatic .xlsx files uploading from [Ministry of Health web service](https://www.gov.pl/web/zdrowie/obwieszczenia-ministra-zdrowia-lista-lekow-refundowanych) into python + data cleansing and loading datasets into **postgreSQL database**.

On the unit level the proccess looks like that:

`Python`

1. Scraping href attributes of the HTML <a> elemnt within 'file-download' class which store .xlsx files from a [subpage](https://www.gov.pl/web/zdrowie/obwieszczenie-ministra-zdrowia-z-dnia-18-lutego-2020-r-w-sprawie-wykazu-refundowanych-lekow-srodkow-spozywczych-specjalnego-przeznaczenia-zywieniowego-oraz-wyrobow-medycznych-na-1-marca-2020-r) of the Ministry of Health web service and load a selectef filee into pandas dataframe specyfying sheet name and columns to load (as well as other required parameters):


````python
import requests as REQ
from bs4 import BeautifulSoup as BS
import pandas
import urllib.request
URL = ‘https://www.gov.pl/web/zdrowie/obwieszczenie-ministra-zdrowia-z-dnia-18-lutego-2020-r-w-sprawie-wykazu-refundowanych-lekow-srodkow-spozywczych-specjalnego-przeznaczenia-zywieniowego-oraz-wyrobow-medycznych-na-1-marca-2020-r’
page = REQ.get(URL)
soup = BS(page.content, 'html.parser')
files = soup.find_all("a", class_='file-download') # hrefs for file to be downloaded are located within <a> elemnt of file-download class 
hrefs = [] # an empty list 
prefix = ‘https://www.gov.pl’
for link in files:
	href = link.get('href')
	hrefs.append(prefix + href)


target_URL = hrefs[5] # the 5th element of hrefs’ list is a link holding a target file.
single_dataset =pandas.read_excel(target_URL, ['A1'], header = 2, index_col = 0, usecols = [0,1,2,4,5,6,8,9,10,11,14]) # loading an 'A1' sheet as a pandas.dataframe object within a dict
a1_sheet = single_dataset['A1']

````
2. Convert pandas columns (**Series**) data types as required to be able to perform operations on dataframe:
```python
a1_sheet.dtypes # use .dtypes attribute to check if columns data types are correct
#Substancja czynna                                object
#Nazwa  postać i dawka                            object
#Kod EAN lub inny kod odpowiadający kodowi EAN     int64
#Termin wejścia w życie decyzji                   object
#Okres obowiązywania decyzji                      object
#Urzędowa cena zbytu                              object
#Cena hurtowa brutto                              object
#Cena detaliczna                                  object
#Wysokość limitu finansowania                     object
#Poziom odpłatności                               object
#dtype: object
`````
#To change the data types of a set of columns that store cost data into **float64** data type, use astype() method. If your decimal sign is a comma "," (which is typical for storing decimal numbers in Poland) and not a dot "." , change it:

```python



````


