package com.adventnet.cskbank;

/** <p> Description of the table <code>Customer</code>.
 *  Column Name and Table Name of  database table  <code>Customer</code> is mapped
 * as constants in this util.</p> 
   * 
  * Primary Key for this definition is  <br>
  <ul>
  * <li> {@link #USER_ID}
  * </ul>
 */
 
public final class CUSTOMER
{
    private CUSTOMER()
    {
    }
   
    /** Constant denoting the Table Name of this definition.
     */
    public static final String TABLE = "Customer" ;
    /**
                            * This column is an Primary Key for this Table definition. <br>
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String USER_ID= "USER_ID" ;

    /*
    * The index position of the column USER_ID in the table.
    */
    public static final int USER_ID_IDX = 1 ;

    /**
                            * Data Type of this field is <code>CTEXT_CEK</code>. <br>
                     * Maximum length of this field value is <code>100</code>. <br>
                                   * This field is not nullable. <br>
                                */
    public static final String AADHAAR= "AADHAAR" ;

    /*
    * The index position of the column AADHAAR in the table.
    */
    public static final int AADHAAR_IDX = 2 ;

    /**
                            * Data Type of this field is <code>CTEXT_CEK</code>. <br>
                     * Maximum length of this field value is <code>100</code>. <br>
                                   * This field is not nullable. <br>
                                */
    public static final String PAN= "PAN" ;

    /*
    * The index position of the column PAN in the table.
    */
    public static final int PAN_IDX = 3 ;

}
