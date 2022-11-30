
{% macro apply_pii_tags_models(results) %}

  {{ log('apply_pii_tags_models', info=True) }}

  {% if execute %}   
    {%- set tags_by_schema = {} -%}    
    {% for res in results -%}

            {% for column in res.node.columns if 'pii' in res.node.columns[column].tags  -%}     

            {%- set database = res.node.database.name -%}
            {%- set schema = res.node.schema -%}
            {%- set alias = res.node.alias -%}

            {%- set pii_column = res.node.columns[column].name -%} 

               {{set_column_tag_pii(schema,alias,pii_column)}}  

            {% endfor %}   
            
    {% endfor %} 
  {% endif %}
{% endmacro %}



{% macro set_column_tag_pii(schema,table_name,column_name) %}
        {%- call statement('main', fetch_result=True) -%}

            alter table {{schema}}.{{table_name}} modify column {{column_name}} set tag MASKING_POLICIES.pii = 'pii'
           
        {%- endcall -%}

{% endmacro %}

