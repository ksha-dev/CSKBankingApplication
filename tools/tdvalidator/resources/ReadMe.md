External tool for validating TableDefinition without starting MickeyLite server.

    1. Place the validate.sh file from tools/tdvalidator/validate.sh to <app-home>
    2. Implement the TDValidator Interface and add custom validations in it
    3. Place the jar inside lib folder 
    4. Call ./validate.sh <YourTDValidatorClassName

Note : For Windows validate.bat file needs to be used.
