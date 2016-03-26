## Surplus Donation Application

| **Common (Visible) Field Name** | **Adobe JavaScript Field Name** |
|---|---|
| _Applicant Contact Information_ |
| Name of Organization/Individual | name |
| Date of Application | applicationDate |
| Address | address |
| Organization Contact Name | contactName |
| City | city |
| Phone | phone |
| State and Zip | stateZip |
| Fax | fax | user.address.fax |
| _Minimum Requirements_ |
| Exempt from taxation... | taxExemptYes, taxExemptNo |
| School District (Specify) _text_ | schoolDistrictName |
| School District (Specify) _checkboxes_ | schoolDistrictYes, schoolDistrictNo |
| Special District _text_ | specialDistrictName |
| Special District _checkboxes_ | specialDistrictYes, specialDistrictNo |
| Public Benefits | publicBenefitsYes, publicBenefitsNo |
| _Donation Request_|
| Donation Request | donationRequest |
| _Signature_ |
| Name of Applicant (Please Print) | applicantName |
| Date | signDate |
| Title | title |


**Notes**
 1. Since the document must be printed, wet-signed, and mailed in, there
 is no signature field.
 2. When checking "yes" on one of the organizational/individual options,
 you must check "no" to all the others. I thought about doing this
 programmatically, but since there's no "onChange" option (all of the
 options are physical events, like focus, blur, and mouse events),
 there's no real enforcement in the PDF file.
 3. Have to use hashes in the PDF models because some fields are combined
 or otherwise not in-line with what the database says.
