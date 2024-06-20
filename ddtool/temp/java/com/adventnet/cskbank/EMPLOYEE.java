package com.adventnet.cskbank;

/** <p> Description of the table <code>Employee</code>.
 *  Column Name and Table Name of  database table  <code>Employee</code> is mapped
 * as constants in this util.</p> 
   * 
  * Primary Key for this definition is  <br>
  <ul>
  * <li> {@link #USER_ID}
  * </ul>
 */
 
public final class EMPLOYEE
{
    private EMPLOYEE()
    {
    }
   
    /** Constant denoting the Table Name of this definition.
     */
    public static final String TABLE = "Employee" ;
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
                            * Data Type of this field is <code>INTEGER</code>. <br>
                                          * This field is nullable. <br>
                                */
    public static final String BRANCH_ID= "BRANCH_ID" ;

    /*
    * The index position of the column BRANCH_ID in the table.
    */
    public static final int BRANCH_ID_IDX = 2 ;

}
