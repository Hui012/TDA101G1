<%@page import="com.inbox.model.InboxService"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.inbox.model.InboxVO"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Insert title here</title>
	<link rel=stylesheet type="text/css"
		href="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.css">
	
</head>
<body>
<div class="container-fluid py-3">
    <div class="row">
        <div class="col-md-2">
            <div class="btn-group w-100">
                <button type="button" class="btn btn-primary btn-lg dropdown-toggle" data-toggle="dropdown"> Inbox <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li class="dropdown-item"><a href="#">Mail</a></li>
                    <li class="dropdown-item"><a href="#">Contacts</a></li>
                    <li class="dropdown-item"><a href="#">Tasks</a></li>
                </ul>
            </div>
        </div>
        <div class="col-md-10">
            <div class="btn-group">
                <button type="button" class="btn btn-light">
                    <input type="checkbox" aria-label="..." style="margin:1px;">
                </button>
                <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span><span class="sr-only">Toggle Dropdown</span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li class="dropdown-item"><a href="#">All</a></li>
                    <li class="dropdown-item"><a href="#">None</a></li>
                    <li class="dropdown-item"><a href="#">Read</a></li>
                    <li class="dropdown-item"><a href="#">Unread</a></li>
                    <li class="dropdown-item"><a href="#">Starred</a></li>
                    <li class="dropdown-item"><a href="#">Unstarred</a></li>
                </ul>
            </div>
            <button type="button" class="btn btn-light" data-toggle="tooltip" title="Refresh">
                <i class="fa fa-refresh"></i> </button>
            <div class="btn-group">
                <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown"> More <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li class="dropdown-item"><a href="#">Mark all as read</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-item text-center"><small class="text-muted">Select messages to see more actions</small></li>
                </ul>
            </div>
            <div class="float-right">
                <span class="text-muted"><b>1</b>–<b>50</b> of <b>160</b></span>
                <div class="btn-group btn-group-sm">
                    <button type="button" class="btn btn-default">
                        <span class="fa fa-chevron-left"></span>
                    </button>
                    <button type="button" class="btn btn-default">
                        <span class="fa fa-chevron-right"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <div class="row">
        <!--left-->
        <aside class="col-sm-3 col-md-2 pb-3">
            <a href="#" class="btn btn-danger btn-sm btn-block" role="button"><i class="fa fa-edit"></i> Compose</a>
            <hr>
            <ul class="nav nav-pills flex-column">
                <li class="active"><a href="#"><span class="badge badge-primary float-right">32</span> Inbox </a></li>
                <li><a href="#">Archived</a></li>
                <li><a href="#">Important</a></li>
                <li><a href="#">Sent</a></li>
                <li><a href="#"><span class="badge badge-primary float-right">3</span>Drafts</a></li>
            </ul>
            <hr>
            <div class="storage">
                <small>2.85 GB of <strong>15 GB</strong></small>
                <div class="progress progress-sm">
                    <div class="progress-bar progress-bar-primary" style="width:30%;"></div>
                </div>
            </div>
        </aside>
        <!--main-->
        <div class="col-sm-9 col-md-10">
            <!-- tabs -->
            <ul class="nav nav-tabs border-0">
                <li class="nav-item">
                    <a class="nav-link active" href="#inbox" data-toggle="tab">
                        <i class="fa fa-inbox mr-1"></i> Primary
                    </a>
                </li>
                <li><a href="#profile" class="nav-link" data-toggle="tab">
                    <i class="fa fa-user mr-1"></i> Personal</a></li>
                <li><a href="#settings" class="nav-link" data-toggle="tab">
                    <i class="fa fa-plus"></i>
                    </a>
                </li>
            </ul>
            <!-- tab panes -->
            <div class="tab-content py-4">
                <div class="tab-pane in active" id="inbox">
                    <table class="table table-striped table-hover">
                        <tbody>
                            <!-- inbox header -->
                            <tr>
                                <td>
                                    <btn class="btn btn-outline-primary">
                                        <input type="checkbox" class="all" title="select all"> All 
                                    </btn>
                                </td>
                                <td>
                                    <button class="btn btn-light"><i title="delete selected" class="fa fa-trash"></i></button>
                                    <button class="btn btn-light"><i title="move to folder" class="fa fa-folder-open"></i></button>
                                </td>
                                <td></td>
                            </tr>
                            <!-- inbox item -->
                            <tr>
                                <td>
                                    <label>
                                        <input type="checkbox">
                                    </label> <span class="name text-truncate">Mark Otto</span></td>
                                <td><span class="subject">Nice work on the docs for lastest version</span> <small class="text-muted">- Joe, I just reviewed the last...</small></td>
                                <td><span class="badge">12:10 AM</span> <span class="float-right fa fa-paperclip"></span></td>
                            </tr>
                            <!-- inbox item -->
                            <tr>
                                <td>
                                    <label>
                                        <input type="checkbox">
                                    </label> <span class="name text-truncate">Anil Judah</span></td>
                                <td><span class="subject">GAE Project</span> <small class="text-muted">- Can you take a second to look..</small></td>
                                <td><span class="badge badge-inverse">11:33 AM</span> <span class="float-right fa fa-warning-sign text-danger"></span></td>
                            </tr>
                            <!-- inbox item -->
                            <tr class="unread">
                                <td>
                                    <label>
                                        <input type="checkbox">
                                    </label> <span class="name text-truncate">Terry Lincoln</span></td>
                                <td><span class="subject">Vacation pics</span> <small class="text-muted">(this message contains images)</small></td>
                                <td><span class="badge">11:13 AM</span> <span class="float-right"></span></td>
                            </tr>
                            <!-- inbox item -->
                            <tr>
                                <td>
                                    <label>
                                        <input type="checkbox">
                                    </label> <span class="name text-truncate">Mark Brown</span></td>
                                <td><span class="subject">Last call for this weekend</span> <small class="text-muted">- Hi Joe, Thanks for sending over those..</small></td>
                                <td><span class="badge">11:05 AM</span> <span class="pull-right"></span></td>
                            </tr>
                            <!-- inbox item -->
                            <tr>
                                <td class=" text-truncate">
                                    <label>
                                        <input type="checkbox">
                                    </label> <span class="name text-truncate">Jorge Anodonolgez</span></td>
                                <td><span class="subject">Meeting with Simco</span> <small class="text-muted">- Joe I included your contact info for the...</small></td>
                                <td><span class="badge">10:54 AM</span> <span class="pull-right glyphicon glyphicon-paperclip"></span></td>
                            </tr>
                            <!-- inbox item -->
                            <tr>
                                <td class="text-nowrap">
                                    <label>
                                        <input type="checkbox">
                                    </label> <span class="name text-truncate">Mark Otto</span></td>
                                <td><span class="subject">FYI: New Release</span> <small class="text-muted">this message is high priority</small></td>
                                <td><span class="badge badge-dark">9:58 AM</span> <span class="float-right"></span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane in" id="profile">
                    <div class="list-group">
                        <div class="list-group-item">
                            <span class="text-center">This tab folder is empty.</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row-md-12">
                <div class="card card-body text-right">
                    <small>Last updated: 4/14/2020: 3:02 PM</small>
                </div>
            </div>
        </div>
    </div>
</div>










	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
</body>

</html>