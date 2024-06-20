package com.adventnet.cskbank;

/** <p> Description of the table <code>User</code>.
 *  Column Name and Table Name of  database table  <code>User</code> is mapped
 * as constants in this util.</p> 
   * 
  * Primary Key for this definition is  <br>
  <ul>
  * <li> {@link #USER_ID}
  * </ul>
 */
 
public final class USER
{
    private USER()
    {
    }
   
    /** Constant denoting the Table Name of this definition.
     */
    public static final String TABLE = "User" ;
    /**
                            * This column is an Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String USER_ID= "USER_ID" ;

    /*
    * The index position of the column USER_ID in the table.
    */
    public static final int USER_ID_IDX = 1 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>20</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String FIRST_NAME= "FIRST_NAME" ;

    /*
    * The index position of the column FIRST_NAME in the table.
    */
    public static final int FIRST_NAME_IDX = 2 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>20</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String LAST_NAME= "LAST_NAME" ;

    /*
    * The index position of the column LAST_NAME in the table.
    */
    public static final int LAST_NAME_IDX = 3 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String DOB= "DOB" ;

    /*
    * The index position of the column DOB in the table.
    */
    public static final int DOB_IDX = 4 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                            * Default Value is <code>1</code>. <br>
                     * This field is not nullable. If value for field is not set default value "<code>1</code>" , 
       * will be taken.<br>
                         */
    public static final String GENDER= "GENDER" ;

    /*
    * The index position of the column GENDER in the table.
    */
    public static final int GENDER_IDX = 5 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>255</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String ADDRESS= "ADDRESS" ;

    /*
    * The index position of the column ADDRESS in the table.
    */
    public static final int ADDRESS_IDX = 6 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                                     */
    public static final String PHONE= "PHONE" ;

    /*
    * The index position of the column PHONE in the table.
    */
    public static final int PHONE_IDX = 7 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>30</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String EMAIL= "EMAIL" ;

    /*
    * The index position of the column EMAIL in the table.
    */
    public static final int EMAIL_IDX = 8 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                            * Default Value is <code>1</code>. <br>
                     * This field is not nullable. If value for field is not set default value "<code>1</code>" , 
       * will be taken.<br>
                         */
    public static final String TYPE= "TYPE" ;

    /*
    * The index position of the column TYPE in the table.
    */
    public static final int TYPE_IDX = 9 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String STATUS= "STATUS" ;

    /*
    * The index position of the column STATUS in the table.
    */
    public static final int STATUS_IDX = 10 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String CREATED_AT= "CREATED_AT" ;

    /*
    * The index position of the column CREATED_AT in the table.
    */
    public static final int CREATED_AT_IDX = 11 ;

    /**
                            * Data Type of this field is <code>INTEGER</code>. <br>
                            * Default Value is <code>1</code>. <br>
                     * This field is not nullable. If value for field is not set default value "<code>1</code>" , 
       * will be taken.<br>
                         */
    public static final String MODIFIED_BY= "MODIFIED_BY" ;

    /*
    * The index position of the column MODIFIED_BY in the table.
    */
    public static final int MODIFIED_BY_IDX = 12 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String MODIFIED_AT= "MODIFIED_AT" ;

    /*
    * The index position of the column MODIFIED_AT in the table.
    */
    public static final int MODIFIED_AT_IDX = 13 ;

}
