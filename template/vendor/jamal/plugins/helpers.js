$.fn.extend({
  form_for:function(object){
    var form = document.createElement('form');
    $(form).addClass('model');
    
    if(typeof object == 'string'){
      form.id = object;
      $(form).data('type',object);
      data = new Object();
      data[object] = new Object();
      $(form).data('object', data);
      $(form).attr('action', '/'+form.id.pluralize());    
      $(form).attr('method','post'); 
    }
    else{
      var type ='';
      for(i in object){ type = i }; // Find a better form to extract the key of an object
      $(form).data('object', object);
      $(form).data('type', type);
      $(form).attr('action', '/'+form.id.pluralize()+'/'+object["id"]); 
      $(form).attr('method','post'); 
          
      // Create an id for the form. If the model have id, the id of the form will be f.e. post32
      if(object[type]["id"] != undefined){
        form.id = type+object[type]["id"];
      } else{
        form.id = type;
      }
      
    }
    $(this).append(form);
    
    // Track onChange events for al properties of the objetc that have a form
    $(this).find('.property').live('change',function(){
      var form = $(this).closest('form');
      form.set_attr($(this).data('attribute'), this.value);
    })
        
    return $(form);
  },
  text_field: function(prop){
    var input = document.createElement('input')

    $(input).data('attribute',prop);
    $(input).addClass('property');
    input.id = $(this).data('type')+'['+prop+']';
    input.value = $(this).get_attr(prop);
    input.type = 'text';
    
    // Let be notifed when model changed to update our attributes
    $(this).bind('update',input, function(event){
      event["data"].value = $(event["data"]).closest('form').get_attr($(event["data"]).data('attribute'));
    })
    
    $(this).append(input);
    return $(this);
  },
  text_area: function(prop){
    var area = document.createElement('textarea');
    
    $(area).data('attribute',prop);
    $(area).addClass('property');
    area.id = $(this).data('type')+'['+prop+']';
    area.value = $(this).get_attr(prop);
    
    $(this).append(area);
    
    // Let be notifed when model changed to update our attributes
    $(this).bind('update',area, function(event){
      
      event["data"].value = $(event["data"]).closest('form').get_attr($(event["data"]).data('attribute'));
    })
    
    return $(this);
  },
  submit_tag: function(){
    var input = document.createElement('input');
    input.type ='submit';
    $(this).append(input);
    return $(this);
  },
  label: function(prop,name){
    var label = document.createElement('label');
    label.innerHTML = name;
    label.setAttribute('for', $(this).data('type')+'['+prop+']')
    $(this).append(label);
    return $(this)
  },
  get_model: function(){
    return $(this).data('object')[$(this).data('type')];
  },
  set_model:function(object){
    $(this).data('object',object);
    $(this).find('.property').trigger('update')
    return $(this);
  },
  get_attr: function(attr){
    try{
      var data = $(this).data('object')[$(this).data('type')];
      if(data[attr] == undefined){
        return '';
      }else{
        return data[attr];
      }
    }catch(e){
      return null;
    }
  },
  set_attr: function(attr,value){
    object = $(this).data('object')    
    object[$(this).data('type')][attr] = value;
  },
  
})
