<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users — NestWood Admin</title>
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="admin-layout">

<%@ include file="/WEB-INF/includes/admin-header.jsp" %>

<main class="admin-main">

    <div class="admin-page-header">
        <div>
            <h2><i class="fas fa-user-friends" aria-hidden="true" style="color: var(--gold);"></i> Users Management</h2>
            <p>Manage and monitor registered users</p>
        </div>
    </div>

    <%-- Success/Error Messages --%>
    <c:if test="${param.success == 'approved'}">
        <div class="alert alert-success" style="margin-bottom: 1.5rem;">
            <i class="fas fa-check-circle"></i> User approved successfully!
        </div>
    </c:if>
    <c:if test="${param.success == 'rejected'}">
        <div class="alert alert-success" style="margin-bottom: 1.5rem;">
            <i class="fas fa-check-circle"></i> User rejected successfully!
        </div>
    </c:if>
    <c:if test="${param.error == 'failed'}">
        <div class="alert alert-error" style="margin-bottom: 1.5rem;">
            <i class="fas fa-exclamation-circle"></i> Failed to update user status. Please try again.
        </div>
    </c:if>

    <%-- User Stats Cards --%>
    <div class="stats-grid" style="margin-bottom: 2rem;">
        <div class="stat-card">
            <div class="stat-icon" style="background: transparent; color: var(--gold); font-size: 2.5rem;">
                <i class="fas fa-user-friends"></i>
            </div>
            <div class="stat-content">
                <p class="stat-label">Total Users</p>
                <h3 class="stat-value">${users.size()}</h3>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: transparent; color: var(--gold); font-size: 2.5rem;">
                <i class="fas fa-user-tie"></i>
            </div>
            <div class="stat-content">
                <p class="stat-label">Admins</p>
                <h3 class="stat-value">
                    <c:set var="adminCount" value="0"/>
                    <c:forEach var="u" items="${users}">
                        <c:if test="${u.role eq 'admin'}">
                            <c:set var="adminCount" value="${adminCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${adminCount}
                </h3>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: transparent; color: var(--gold); font-size: 2.5rem;">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-content">
                <p class="stat-label">Regular Users</p>
                <h3 class="stat-value">
                    <c:set var="userCount" value="0"/>
                    <c:forEach var="u" items="${users}">
                        <c:if test="${u.role eq 'user'}">
                            <c:set var="userCount" value="${userCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${userCount}
                </h3>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: transparent; color: var(--gold); font-size: 2.5rem;">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-content">
                <p class="stat-label">Pending Approval</p>
                <h3 class="stat-value">
                    <c:set var="pendingCount" value="0"/>
                    <c:forEach var="u" items="${users}">
                        <c:if test="${u.status eq 'pending'}">
                            <c:set var="pendingCount" value="${pendingCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${pendingCount}
                </h3>
            </div>
        </div>
    </div>

    <%-- Users Table Card --%>
    <div class="card" style="border-radius: 16px; overflow: hidden; box-shadow: 0 4px 20px rgba(60,40,20,0.08);">
        <div class="card-header" style="background: linear-gradient(135deg, #F5F1E8 0%, #FFFFFF 100%); padding: 1.5rem; border-bottom: 2px solid var(--border);">
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <h3 style="font-size: 1.25rem; font-weight: 600; color: var(--text); margin: 0;">
                    <i class="fas fa-table" aria-hidden="true" style="color: var(--gold); margin-right: 0.5rem;"></i>
                    All Users
                </h3>
                <div style="display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
                    <%-- Role Filter Buttons --%>
                    <div style="display: flex; gap: 0.5rem; background: var(--cream-dark); padding: 4px; border-radius: 8px;">
                        <button onclick="filterByRole('all')" id="filterAll" 
                                style="padding: 6px 16px; border: none; border-radius: 6px; font-size: 0.85rem; font-weight: 600; cursor: pointer; transition: all 0.2s; background: var(--gold); color: white;">
                            All
                        </button>
                        <button onclick="filterByRole('admin')" id="filterAdmin" 
                                style="padding: 6px 16px; border: none; border-radius: 6px; font-size: 0.85rem; font-weight: 600; cursor: pointer; transition: all 0.2s; background: transparent; color: var(--text-mid);">
                            <i class="fas fa-user-tie" aria-hidden="true" style="font-size: 0.75rem;"></i> Admins
                        </button>
                        <button onclick="filterByRole('user')" id="filterUser" 
                                style="padding: 6px 16px; border: none; border-radius: 6px; font-size: 0.85rem; font-weight: 600; cursor: pointer; transition: all 0.2s; background: transparent; color: var(--text-mid);">
                            <i class="fas fa-user" aria-hidden="true" style="font-size: 0.75rem;"></i> Users
                        </button>
                    </div>
                    <%-- Search Box --%>
                    <div style="position: relative;">
                        <i class="fas fa-search" aria-hidden="true" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--text-muted); font-size: 0.85rem;"></i>
                        <input type="text" id="userSearch" placeholder="Search users..." 
                               style="padding: 8px 12px 8px 36px; border: 1.5px solid var(--border); border-radius: 8px; font-size: 0.85rem; width: 250px; transition: var(--t);"
                               onkeyup="searchUsers()">
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="data-table" id="usersTable" style="margin: 0;">
                    <thead style="background: var(--cream-dark);">
                        <tr>
                            <th style="padding: 1rem; font-weight: 600; color: var(--text); text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px;">ID</th>
                            <th style="padding: 1rem; font-weight: 600; color: var(--text); text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px;">User</th>
                            <th style="padding: 1rem; font-weight: 600; color: var(--text); text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px;">Email</th>
                            <th style="padding: 1rem; font-weight: 600; color: var(--text); text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px;">Phone</th>
                            <th style="padding: 1rem; font-weight: 600; color: var(--text); text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px;">Role</th>
                            <th style="padding: 1rem; font-weight: 600; color: var(--text); text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px;">Status</th>
                            <th style="padding: 1rem; font-weight: 600; color: var(--text); text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px;">Registered</th>
                            <th style="padding: 1rem; font-weight: 600; color: var(--text); text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr style="border-bottom: 1px solid var(--border-light); transition: all 0.2s ease;" 
                                onmouseover="this.style.background='var(--cream-dark)'" 
                                onmouseout="this.style.background='transparent'">
                                <td style="padding: 1.25rem 1rem;">
                                    <span style="font-weight: 600; color: var(--text-mid);">${user.id}</span>
                                </td>
                                <td style="padding: 1.25rem 1rem;">
                                    <div style="display:flex;align-items:center;gap:12px">
                                        <c:choose>
                                            <c:when test="${not empty user.avatar && user.avatar != 'default.png'}">
                                                <img src="${pageContext.request.contextPath}/assets/images/uploads/${user.avatar}" 
                                                     alt="${user.fullName}" 
                                                     style="width:40px;height:40px;min-width:40px;min-height:40px;border-radius:50%;object-fit:cover;border:2px solid var(--border);flex-shrink:0;" />
                                            </c:when>
                                            <c:otherwise>
                                                <div style="width:40px;height:40px;min-width:40px;min-height:40px;border-radius:50%;background:linear-gradient(135deg, var(--gold) 0%, var(--gold-dark) 100%);color:white;display:flex;align-items:center;justify-content:center;font-size:1rem;font-weight:600;box-shadow: 0 2px 8px rgba(212,175,55,0.3);flex-shrink:0;">
                                                    ${user.fullName.substring(0,1).toUpperCase()}
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <div style="font-weight: 600; color: var(--text); font-size: 0.95rem;">${user.fullName}</div>
                                        </div>
                                    </div>
                                </td>
                                <td style="padding: 1.25rem 1rem;">
                                    <div style="display: flex; align-items: center; gap: 6px; color: var(--text-mid); font-size: 0.9rem;">
                                        <i class="fas fa-envelope" aria-hidden="true" style="color: var(--gold); font-size: 0.8rem;"></i>
                                        ${user.email}
                                    </div>
                                </td>
                                <td style="padding: 1.25rem 1rem;">
                                    <div style="display: flex; align-items: center; gap: 6px; color: var(--text-mid); font-size: 0.9rem;">
                                        <i class="fas fa-phone" aria-hidden="true" style="color: var(--gold); font-size: 0.8rem;"></i>
                                        ${user.phone}
                                    </div>
                                </td>
                                <td style="padding: 1.25rem 1rem;">
                                    <c:choose>
                                        <c:when test="${user.role == 'admin'}">
                                            <span style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; border-radius: 20px; background: linear-gradient(135deg, #FDF6EC 0%, #F5EDD8 100%); color: #8C5A18; border: 1px solid #E8CFA0; font-size: 0.8rem; font-weight: 600; letter-spacing: 0.3px;">
                                                <i class="fas fa-user-tie" aria-hidden="true" style="font-size: 0.75rem;"></i>
                                                Admin
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; border-radius: 20px; background: linear-gradient(135deg, #F0F7F2 0%, #E8F5EC 100%); color: #2A6040; border: 1px solid #B8DEC8; font-size: 0.8rem; font-weight: 600; letter-spacing: 0.3px;">
                                                <i class="fas fa-user" aria-hidden="true" style="font-size: 0.75rem;"></i>
                                                User
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 1.25rem 1rem;">
                                    <c:choose>
                                        <c:when test="${user.status == 'approved'}">
                                            <span style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; border-radius: 20px; background: linear-gradient(135deg, #E8F5E9 0%, #C8E6C9 100%); color: #2E7D32; border: 1px solid #A5D6A7; font-size: 0.8rem; font-weight: 600;">
                                                <i class="fas fa-check-circle" aria-hidden="true" style="font-size: 0.75rem;"></i>
                                                Approved
                                            </span>
                                        </c:when>
                                        <c:when test="${user.status == 'pending'}">
                                            <span style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; border-radius: 20px; background: linear-gradient(135deg, #FFF3E0 0%, #FFE0B2 100%); color: #E65100; border: 1px solid #FFCC80; font-size: 0.8rem; font-weight: 600;">
                                                <i class="fas fa-clock" aria-hidden="true" style="font-size: 0.75rem;"></i>
                                                Pending
                                            </span>
                                        </c:when>
                                        <c:when test="${user.status == 'rejected'}">
                                            <span style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; border-radius: 20px; background: linear-gradient(135deg, #FFEBEE 0%, #FFCDD2 100%); color: #C62828; border: 1px solid #EF9A9A; font-size: 0.8rem; font-weight: 600;">
                                                <i class="fas fa-times-circle" aria-hidden="true" style="font-size: 0.75rem;"></i>
                                                Rejected
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--text-muted);">—</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 1.25rem 1rem;">
                                    <div style="display: flex; align-items: center; gap: 6px; color: var(--text-muted); font-size: 0.85rem;">
                                        <i class="fas fa-calendar" aria-hidden="true" style="color: var(--gold); font-size: 0.75rem;"></i>
                                        <c:choose>
                                            <c:when test="${not empty user.createdAt}">
                                                ${user.createdAt}
                                            </c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td style="padding: 1.25rem 1rem;">
                                    <c:if test="${user.role != 'admin' && user.status == 'pending'}">
                                        <div style="display: flex; gap: 0.5rem;">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display: inline;">
                                                <input type="hidden" name="userId" value="${user.id}"/>
                                                <input type="hidden" name="action" value="approve"/>
                                                <button type="submit" style="padding: 6px 12px; background: linear-gradient(135deg, #4CAF50 0%, #45A049 100%); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; font-weight: 600; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 4px;" 
                                                        onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 12px rgba(76,175,80,0.3)'" 
                                                        onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                                                    <i class="fas fa-check" aria-hidden="true"></i> Approve
                                                </button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display: inline;">
                                                <input type="hidden" name="userId" value="${user.id}"/>
                                                <input type="hidden" name="action" value="reject"/>
                                                <button type="submit" style="padding: 6px 12px; background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%); color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 0.8rem; font-weight: 600; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 4px;" 
                                                        onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 12px rgba(244,67,54,0.3)'" 
                                                        onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                                                    <i class="fas fa-times" aria-hidden="true"></i> Reject
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                    <c:if test="${user.role == 'admin' || user.status != 'pending'}">
                                        <span style="color: var(--text-muted); font-size: 0.85rem;">—</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="8" style="text-align:center;padding:3rem;color:var(--text-light)">
                                    <div style="display: flex; flex-direction: column; align-items: center; gap: 1rem;">
                                        <div style="width: 80px; height: 80px; border-radius: 50%; background: var(--cream-dark); display: flex; align-items: center; justify-content: center;">
                                            <i class="fas fa-users" aria-hidden="true" style="font-size:2.5rem;opacity:0.3;color:var(--text-muted)"></i>
                                        </div>
                                        <div>
                                            <p style="font-size: 1.1rem; font-weight: 600; color: var(--text-mid); margin-bottom: 0.25rem;">No users found</p>
                                            <p style="font-size: 0.9rem; color: var(--text-muted);">There are no registered users yet</p>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</main>

<script>
let currentRoleFilter = 'all';

function filterByRole(role) {
    currentRoleFilter = role;
    
    // Update button styles
    document.getElementById('filterAll').style.background = role === 'all' ? 'var(--gold)' : 'transparent';
    document.getElementById('filterAll').style.color = role === 'all' ? 'white' : 'var(--text-mid)';
    
    document.getElementById('filterAdmin').style.background = role === 'admin' ? 'var(--gold)' : 'transparent';
    document.getElementById('filterAdmin').style.color = role === 'admin' ? 'white' : 'var(--text-mid)';
    
    document.getElementById('filterUser').style.background = role === 'user' ? 'var(--gold)' : 'transparent';
    document.getElementById('filterUser').style.color = role === 'user' ? 'white' : 'var(--text-mid)';
    
    // Apply filter
    applyFilters();
}

function searchUsers() {
    applyFilters();
}

function applyFilters() {
    const searchInput = document.getElementById('userSearch');
    const searchFilter = searchInput.value.toLowerCase();
    const table = document.getElementById('usersTable');
    const rows = table.getElementsByTagName('tr');
    
    for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const cells = row.getElementsByTagName('td');
        
        if (cells.length === 0) continue;
        
        // Get role from the badge
        const roleCell = cells[4]; // Role column
        const roleText = roleCell.textContent.trim().toLowerCase();
        
        // Check role filter
        let roleMatch = currentRoleFilter === 'all' || roleText.includes(currentRoleFilter);
        
        // Check search filter
        let searchMatch = true;
        if (searchFilter) {
            searchMatch = false;
            for (let j = 0; j < cells.length; j++) {
                const cell = cells[j];
                if (cell) {
                    const text = cell.textContent || cell.innerText;
                    if (text.toLowerCase().indexOf(searchFilter) > -1) {
                        searchMatch = true;
                        break;
                    }
                }
            }
        }
        
        // Show row only if both filters match
        row.style.display = (roleMatch && searchMatch) ? '' : 'none';
    }
}
</script>

</body>
</html>
