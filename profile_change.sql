PROMPT List Site level Profiles that have changed in last Month
SELECT
         o.user_profile_option_name user_prof_name
       , substr(v.profile_option_value, 1,45) prof_value
       , fu.user_name
       , to_char(v.last_update_date,'DD-Mon-YYYY') update_date
FROM     apps.fnd_profile_option_values v
       , apps.fnd_profile_options_vl o
       , apps.fnd_user fu
WHERE    o.profile_option_id = v.profile_option_id
AND      o.application_id    = v.application_id
AND      level_id = 10001
AND      v.last_updated_by = fu.user_id
AND      (v.last_update_date >= sysdate - 5 -- updated in last 4 weeks
          OR v.creation_date >=  sysdate -5)  -- created in the last 4 weeks
ORDER BY fu.user_name, o.user_profile_option_name
/
