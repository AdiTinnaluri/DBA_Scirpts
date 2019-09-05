
select
 'USER_NAME..........................:    '||USER_NAME
 || CHR(10)  || 'EMAIL_ADDRESS......................:    '||EMAIL_ADDRESS
FROM fnd_user
where user_name = upper('&U_NAME')
/

