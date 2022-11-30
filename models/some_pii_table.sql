select
    Name
    bank_account
    CITY
    CUSTOM01
from {{source('some_pii_table', 'some_pii_table')}}


