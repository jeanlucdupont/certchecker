{include file="header.tpl"}

		<div class="container-fluid page-body-wrapper">
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-info font-weight-bold">244</h2>
										<i class="mdi mdi-file-document-outline mdi-18px text-dark"></i>
									</div>
								</div>
								<canvas id="invoices"></canvas>
								<div class="line-chart-row-title">Sites</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-danger font-weight-bold">7826</h2>
										<i class="mdi mdi-cash text-dark mdi-18px"></i>
									</div>
								</div>
								<canvas id="transactions"></canvas>
								<div class="line-chart-row-title">Sites at risk</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-danger font-weight-bold">18390</h2>
										<i class="mdi mdi-account-outline mdi-18px text-dark"></i>
									</div>
								</div>
								<canvas id="newClient"></canvas>
								<div class="line-chart-row-title">Expired certificates</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-warning font-weight-bold">839</h2>
										<i class="mdi mdi-refresh mdi-18px text-dark"></i>
									</div>
								</div>
								<canvas id="allProducts"></canvas>
								<div class="line-chart-row-title">About to expire certificates</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-danger font-weight-bold">3259</h2>
										<i class="mdi mdi-folder-outline mdi-18px text-dark"></i>
									</div>
								</div>
								<canvas id="projects"></canvas>
								<div class="line-chart-row-title">Failed connections</div>
							</div>
						</div>
						<div class="col-lg-2 grid-margin stretch-card">
							<div class="card">
								<div class="card-body pb-0">
									<div class="d-flex align-items-center justify-content-between">
										<h2 class="text-danger font-weight-bold">586</h2>
										<i class="mdi mdi-cart-outline mdi-18px text-dark"></i>
									</div>
								</div>
								<canvas id="orderRecieved"></canvas>
								<div class="line-chart-row-title">Weak encryptions</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm grid-margin grid-margin-md-0 stretch-card">
							<div class="card">
								<div class="card-body">
									<div class="d-flex align-items-center justify-content-between">
										<h4 class="card-title">Support Tracker</h4>
										<h4 class="text-success font-weight-bold">Tickets<span class="text-dark ms-3">163</span></h4>
									</div>
									
									
									<div class="container">
	<div class="col-md-12">
    	<div class="panel panel-default">
				<div class="panel-heading">
					Employee
				</div>
        <div class="panel-body">
					<table class="table table-condensed table-striped">
    <thead>
        <tr>
					<th></th>
          <th>Fist Name</th>
          <th>Last Name</th>
          <th>City</th>
          <th>State</th>
          <th>Status</th>
        </tr>
    </thead>

    <tbody>
        <tr data-toggle="collapse" data-target="#demo1" class="accordion-toggle">
           <td><button class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span></button></td>
            <td>Carlos</td>
            <td>Mathias</td>
            <td>Leme</td>
            <td>SP</td>
          	<td>new</td>
        </tr>
			
        <tr>
            <td colspan="12" class="hiddenRow">
							<div class="accordian-body collapse" id="demo1"> 
              <table class="table table-striped">
                      <thead>
                        <tr class="info">
													<th>Job</th>
													<th>Company</th>
													<th>Salary</th>		
													<th>Date On</th>	
													<th>Date off</th>	
													<th>Action</th>	
												</tr>
											</thead>	
								  		
											<tbody>
												
                        <tr data-toggle="collapse"  class="accordion-toggle" data-target="#demo10">
													<td> <a href="#">Enginner Software</a></td>
													<td>Google</td>
													<td>U$8.00000 </td>
													<td> 2016/09/27</td>
													<td> 2017/09/27</td>
													<td> 
														<a href="#" class="btn btn-default btn-sm">
                 								 <i class="glyphicon glyphicon-cog"></i>
															</a>
													</td>
												</tr>
												
												 <tr>
            <td colspan="12" class="hiddenRow">
							<div class="accordian-body collapse" id="demo10"> 
              <table class="table table-striped">
                      <thead>
                        <tr>
													<td><a href="#"> XPTO 1</a></td>
													<td>XPTO 2</td>
													<td>Obs</td>
												</tr>
                        <tr>
													<th>item 1</th>
													<th>item 2</th>
													<th>item 3 </th>
													<th>item 4</th>
													<th>item 5</th>
													<th>Actions</th>
												</tr>
                      </thead>
                      <tbody>
                        <tr>
													<td>item 1</td>
													<td>item 2</td>
													<td>item 3</td>
													<td>item 4</td>
													<td>item 5</td>
													<td>
															<a href="#" class="btn btn-default btn-sm">
                  							<i class="glyphicon glyphicon-cog"></i>
															</a>
													</td>
												</tr>
                      </tbody>
               	</table>
              
              </div> 
          </td>
        </tr>
																										
                        <tr>
													<td>Scrum Master</td>
													<td>Google</td>
													<td>U$8.00000 </td>
													<td> 2016/09/27</td>
													<td> 2017/09/27</td>
													<td> <a href="#" class="btn btn-default btn-sm">
                 								 <i class="glyphicon glyphicon-cog"></i>
															</a>
													</td>
												</tr>
												
														
                        <tr>
													<td>Back-end</td>
													<td>Google</td>
													<td>U$8.00000 </td>
													<td> 2016/09/27</td>
													<td> 2017/09/27</td>
													<td> <a href="#" class="btn btn-default btn-sm">
                 								 <i class="glyphicon glyphicon-cog"></i>
															</a>
													</td>
												</tr>
												
														
                        <tr>
													<td>Front-end</td>
													<td>Google</td>
													<td>U$8.00000 </td>
													<td> 2016/09/27</td>
													<td> 2017/09/27</td>
													<td> <a href="#" class="btn btn-default btn-sm">
                 								 <i class="glyphicon glyphicon-cog"></i>
															</a>
													</td>
												</tr>
								
               
                      </tbody>
               	</table>
              
              </div> 
          </td>
        </tr>
      
      
			
        <tr data-toggle="collapse" data-target="#demo2" class="accordion-toggle">
             <td><button class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span></button></td>
             <td>Silvio</td>
            <td>Santos</td>
            <td>São Paulo</td>
            <td>SP</td>
          <td> new</td>
        </tr>
        <tr>
            <td colspan="6" class="hiddenRow"><div id="demo2" class="accordian-body collapse">Demo2</div></td>
        </tr>
        <tr data-toggle="collapse" data-target="#demo3" class="accordion-toggle">
            <td><button class="btn btn-default btn-xs"><span class="glyphicon glyphicon-eye-open"></span></button></td>
            <td>John</td>
            <td>Doe</td>
            <td>Dracena</td>
            <td>SP</td>
          <td> New</td>
        </tr>
        <tr>
            <td colspan="6" class="hiddenRow"><div id="demo3" class="accordian-body collapse">Demo3 sadasdasdasdasdas</div></td>
        </tr>
    </tbody>
</table>
            </div>
        
          </div> 
        
      </div>
	</div>
       

									
									
									
									
									
									
									
									
									<div id="support-tracker-legend" class="support-tracker-legend"></div>
									<canvas id="supportTracker"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>

{include file="footer.tpl"}