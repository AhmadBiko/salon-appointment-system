#! /bin/bash

echo -e "\n~~~~~ MEN SALON ~~~~~"

#creating PSQL for the database
PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

#welcoming our customer
echo -e "\nWelcome to Our Salon, how can We help you?\n"

#Main Menu
MAIN_MENU(){

if [[ $1 ]]
then
  echo -e "\n$1"
fi

#displaying the services
SERVICES=$($PSQL "SELECT service_id, name FROM services")
echo "$SERVICES" | while IFS='|' read SERVICE_ID NAME
do
  echo "$SERVICE_ID) $NAME" 
done

#reading customer request
read SERVICE_ID_SELECTED

#checking if customer gave a number
if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
then

  #if not number
  MAIN_MENU "We could not find that service. Please make sure to choose one of our services :"

else

  #checking if service_id exists
  if [[ $SERVICE_ID_SELECTED != $($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED;") ]]
  then
  
    MAIN_MENU "We could not find that service. Please make sure to choose one of our services :\n"

  else 

    #service_id exists
    #getting service name
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id =$SERVICE_ID_SELECTED ;")

    #asking for phone number
    echo -e "\nWhat's your phone number?"

    #reading customer number
    read CUSTOMER_PHONE

    #getting customer name
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")

    if [[ -z $CUSTOMER_NAME ]]
    then

      #not found
      echo We don't have a record for that phone number, what's your name?

      #reading customer name
      read CUSTOMER_NAME

      #adding customer to database
      echo $($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")

      echo What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?

      #reading service time
      read SERVICE_TIME

      #getting customer ID
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '$CUSTOMER_NAME';")

      #processing the service appointment
      echo $($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")
      
      #booking message
      echo I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.

    else 

      #found
      echo What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?

      #reading service time
      read SERVICE_TIME

      #getting customer ID
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '$CUSTOMER_NAME';")

      #processing the service appointment
      echo $($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
      
      #booking message
      echo I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.

    fi
  fi
fi

}

#calling the function
MAIN_MENU