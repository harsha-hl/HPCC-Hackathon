# HPCC Systems Hackathon

  ## Problem Statement
  Design a weighted mechanism to match youth to mentoring families. 
1. Weights are provided on the scale of 0 to 5 with 5 being the maximum or most favouring. A number of fields act as parameters in matching a youth with their set of best mentors.
2. A score is to be calculated for each mentor by considering the input from youth and the weight for that field specified by the mentor. The mentor with the highest score is matched with the youth and a list of eligible mentors is to be displayed for that particular youth. 
3. In case a mentor has specified 0 weight for a particular field and the youth specifies it as a requirement, the mentor is to be eliminated. For example, if the gender specified by the youth is male but the weight for gender_male is 0 for a mentor, that mentor is considered ineligible to be matched with the youth irrespective of the mentor's score.
4. Another deciding factor is the distance that should be calculated from the latitude and longitude that is provided from the youth. Mentors should be eliminated incase the calculated distance exceeds that of the limit entered by youth. Mentors from same city as youth having distance 0 can be considered. 
5. Also, if a youth doesn't provide information for a particular field (N/A), it should be verified and be placed under Human Review. A list of fields coming under human review is to be displayed when the youth submits the form. Any invalid inputs or no inputs to required fields must be handled by displaying an error message accordingly.

# Our team *Troubleshooters_2* 's solution

### [Video Demo](https://youtu.be/S4ZRp5gYPaU)
### [Presentation](https://www.canva.com/design/DAFGf9MS1LI/PFJqBWmPJ64xswSXol7iqg/view?utm_content=DAFGf9MS1LI&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

## Haversine formula
![Haversine](images/Haversine.png)
- determines the great-circle distance between two points on a sphere given their longitudes and latitudes.
- high accuracy of 99.5%.
- was used to calculate the distance between the youth and the mentor using their latitudes and longitudes.
![HaversineCode](images/HaversineCode.png)

  
## Score Calculation
### 1. One to multiple mapping
-      Parameters include Religion, AlcoholUse, DrugUse, JobRetention, Continuing Education, SocialStyle, Sexuality, Gender, Biorelationships,                    SupportNeeds
  For the model, I have used a Structured Query Language or SQL database named ```Shoes.db```. It is a relational database management system consisting of 4 tables namely shoes, users, cart and orders. These tables and their respective fields can be viewed using the command ```.schema``` under sqlite3 (an example). Every user and shoe being unique have their own ids which act as primary keys and these keys are referenced to by the foreign keys in tables cart and orders so as to facilitate easy data management across tables.
  
 ![UI1](static/images/ui.png)
 ![UI8](static/images/ui8.png)


## View
  The above images will give you a glimpse of the application / site which a user will be exposed to. Most of the components, hover effects, transisitons and gradients have been implemented using plain css and javascript with html combining the two to make the webpages. Also certain features like navigation bars and alerts have been designed using Bootstrap 4. The user will be able to view products by category and brand, add them to cart, review the prices, select the size and number of pairs they wish to order and also mimic a payment showing the completion of transaction. They will also be able to view their cart items and order history at any given moment. Each of the many webpages present extend a ```layout.html``` file present in the templates folder. This is made possible by using [Jinja](https://jinja.palletsprojects.com/en/3.0.x/), a fast and expressive, extensible templating engine. The images and logos used across the website have been stored in the static folder which also includes other static files such as a video, ```styles.css``` and ```scripts.js``` .

![UI3](static/images/ui3.png)
![UI4](static/images/ui4.png)
  
## Controller
Python language has been used for implementing the backend. The files app.py and helpers.py are responsible for the maintenance of the site. ```Shoes.db``` has been linked to this python code so as to dynamically read or update the database for displaying information on the site. The user will not be able to add items to cart or order them without signing in with a username and password. If the user doesn't have an account already, they can easily create one in the signup page as shown below. Care has been taken so as to prevent users from performing SQL injection attacks and are also prevented from entering invalid data at any of the fields on the site so as to make it reliable. The image of signup and login page can be seen as follows..
  
 ![Signup](static/images/ui9.png)
  

  By default, ```flask run``` command starts flask's built in webserver and runs it on localhost. Using ```flask run --host=0.0.0.0``` changes it to run on all your machine's IP addresses.
  
![UI5](static/images/ui5.png)
![UI6](static/images/ui6.png)
![UI7](static/images/ui7.png)

  ## About CS50
  Building this application wouldn't be possible without the help and guidance offered by the course's instructors David and Brian. From all-nighter Tideman to fascinating Filters and Fiftyville, the course has been truly amazing with its collection of problem sets and labs. I have enjoyed being a part of cs50 and would certainly recommend it to anyone interested in the domain of computer science.
  
