$( document ).on('turbolinks:load', function() {
      $('#bootstrap-data-table-export').DataTable();

      var off_name = document.getElementById("variable3").value;

      if(off_name != ""){
            document.getElementById("office_name").value = off_name
      }

      $("input#office_name").keyup(function(){
            var url = "/job_orders/live_search2";
            var y = document.getElementById("live-results");

            var formData= $.param($("#office_name").map(function(){
                  return {
                        value:  document.getElementById('office_name').value
                  }
            }));
            $.get(url, formData, function(html) {
                  if(y.style.display == "none"){
                        y.style.display = "block"
                  }
                  $("#live-results").html(html);
                  $("#myUL2 li").on("click", function(){
                        document.getElementById('office_name').value = $(this).text()
                        document.getElementById('office_id').value = this.id
                        y.style.display = "none"
                  });
            });
    });


      var job_type = document.getElementById('variable').value;
      console.log("Job type: " + job_type + "Wiw");
      if(!toBeChecked(job_type, "Aircon cleaning/repair/install") && !toBeChecked(job_type, "Bulb Tube Replacement") && !toBeChecked(job_type, "Carpentry/ Fabrication work/ repair") &&
            !toBeChecked(job_type, "Computer Hardware Servicing") && !toBeChecked(job_type, "Computer Software Servicing") &&!toBeChecked(job_type, "Cost Estimate Formulation / POW") &&
            !toBeChecked(job_type, "DLP/LCD Services") &&!toBeChecked(job_type, "Door knob installation/repair") &&!toBeChecked(job_type, "Electric fan cleaning/repair") &&
            !toBeChecked(job_type, "Electrical installation/repair") &&!toBeChecked(job_type, "Internet & network problems") &&!toBeChecked(job_type, "Inventory taking & recording") &&
            !toBeChecked(job_type, "Painting/Repainting/Varnish works") && !toBeChecked(job_type, "Photography/Video coverage") &&!toBeChecked(job_type, "Plumbing/Sanitary Install/repair") &&
            !toBeChecked(job_type, "Printer/ Peripheral related problems") &&!toBeChecked(job_type, "Request for Personnel assistance") &&!toBeChecked(job_type, "Sounds & lights services") &&
            !toBeChecked(job_type, "Streamer/Signage making") &&!toBeChecked(job_type, "Streamer installation") &&!toBeChecked(job_type, "Transfer/Transport items(see listing)" && job_type != "") ){
            document.getElementById('others').checked = true;
            document.getElementById('specify').disabled = false;
            document.getElementById('specify').value = job_type;
      }
   
      document.getElementById('option1').disabled = true;
      document.getElementById('option2').disabled = true;
      document.getElementById('option3').disabled = true;
      document.getElementById('option4').disabled = true;
      document.getElementById('option5').disabled = true;
      document.getElementById('option6').disabled = true;
      document.getElementById('option7').disabled = true;
      document.getElementById('option8').disabled = true;
      document.getElementById('option9').disabled = true;
      document.getElementById('option10').disabled = true;
      document.getElementById('option11').disabled = true;
      document.getElementById('option12').disabled = true;
      document.getElementById('option13').disabled = true;
      document.getElementById('option14').disabled = true;
      document.getElementById('option15').disabled = true;
      document.getElementById('option16').disabled = true;
      document.getElementById('option17').disabled = true;
      document.getElementById('option18').disabled = true;
      document.getElementById('option19').disabled = true;
      document.getElementById('option20').disabled = true;
      document.getElementById('option21').disabled = true;
      document.getElementById('others').disabled = true;

      document.getElementById('control_no').disabled = true;
      document.getElementById('where').disabled = true;
      document.getElementById('date_needed').disabled = true;
      document.getElementById('time_needed').disabled = true;
      document.getElementById('order').disabled = true;
      document.getElementById('requester').disabled = true;
      document.getElementById('adviser').disabled = true;
      document.getElementById('fund').disabled = true;
  });
  function toBeChecked(job_type, value){
    if(job_type == value){
      return true;
    }
    return false;
  }

