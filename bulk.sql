declare

v_guid varchar2(150);
v_num  number(10);

cursor c1 is select user_name from fnd_user where user_guid is null and end_date is null and user_name like 'E0052685';

begin

for i in c1 

loop

-- For 12.1.2
v_guid := fnd_ldap_user.GET_USER_GUID_AND_COUNT(i.user_name,v_num);

-- For 12.1.1

--v_guid := fnd_ldap_user.GET_USER_GUID(i.user_name);

update fnd_user set user_guid=v_guid where user_name=i.user_name;

end loop;

end;
