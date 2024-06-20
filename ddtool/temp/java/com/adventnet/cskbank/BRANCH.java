package com.adventnet.cskbank;

/** <p> Description of the table <code>Branch</code>.
 *  Column Name and Table Name of  database table  <code>Branch</code> is mapped
 * as constants in this util.</p> 
   * 
  * Primary Key for this definition is  <br>
  <ul>
  * <li> {@link #BRANCH_ID}
  * </ul>
 */
 
public final class BRANCH
{
    private BRANCH()
    {
    }
   
    /** Constant denoting the Table Name of this definition.
     */
    public static final String TABLE = "Branch" ;
    /**
                            * This column is an Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String BRANCH_ID= "BRANCH_ID" ;

    /*
    * The index position of the column BRANCH_ID in the table.
    */
    public static final int BRANCH_ID_IDX = 1 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>20</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String NAME= "NAME" ;

    /*
    * The index position of the column NAME in the table.
    */
    public static final int NAME_IDX = 2 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>255</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String ADDRESS= "ADDRESS" ;

    /*
    * The index position of the column ADDRESS in the table.
    */
    public static final int ADDRESS_IDX = 3 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                                     */
    public static final String PHONE= "PHONE" ;

    /*
    * The index position of the column PHONE in the table.
    */
    public static final int PHONE_IDX = 4 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>30</code>. <br>
                                   * This field is nullable. <br>
                                                     */
    public static final String EMAIL= "EMAIL" ;

    /*
    * The index position of the column EMAIL in the table.
    */
    public static final int EMAIL_IDX = 5 ;

    /**
                            * Data Type of this field is <code>CHAR</code>. <br>
                     * Maximum length of this field value is <code>11</code>. <br>
                                   * This field is not nullable. <br>
                                                     */
    public static final String IFSC_CODE= "IFSC_CODE" ;

    /*
    * The index position of the column IFSC_CODE in the table.
    */
    public static final int IFSC_CODE_IDX = 6 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                            * Default Value is <code>0</code>. <br>
                     * This field is not nullable. If value for field is not set default value "<code>0</code>" , 
       * will be taken.<br>
                         */
    public static final String ACCOUNTS_COUNT= "ACCOUNTS_COUNT" ;

    /*
    * The index position of the column ACCOUNTS_COUNT in the table.
    */
    public static final int ACCOUNTS_COUNT_IDX = 7 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String CREATED_AT= "CREATED_AT" ;

    /*
    * The index position of the column CREATED_AT in the table.
    */
    public static final int CREATED_AT_IDX = 8 ;

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
    public static final int MODIFIED_BY_IDX = 9 ;

    /**
                            * Data Type of this field is <code>BIGINT</code>. <br>
                                          * This field is not nullable. <br>
                                */
    public static final String MODIFIED_AT= "MODIFIED_AT" ;

    /*
    * The index position of the column MODIFIED_AT in the table.
    */
    public static final int MODIFIED_AT_IDX = 10 ;

}
