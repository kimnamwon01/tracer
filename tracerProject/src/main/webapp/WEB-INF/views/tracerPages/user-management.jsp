<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRACER - 회원 목록</title>
    
    <!-- CSS includes -->
    <link id="theme-style" rel="stylesheet" href="assets/css/portal.css">

    <!-- Vue.js -->
    <script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <!-- JQuery and Bootstrap (Optional) -->
    <script src="${path}/a00_com/jquery.min.js"></script>
    <script src="${path}/a00_com/popper.min.js"></script>
    <script src="${path}/a00_com/bootstrap.min.js"></script>

    <style>
        /* 추가적인 스타일 정의 가능 */
    </style>
</head>
<body>
<div id="app">
<br>
<jsp:include page="/headerSidebar.jsp"/>s
        <!-- Vue.js 애플리케이션 -->
        <div class="app-wrapper" id="memberList">
            <div class="app-content pt-3 p-md-3 p-lg-4">
                <div class="container-xl">
                    <div class="row g-3 mb-4 align-items-center justify-content-between">
                        <div class="col-auto">
                            <h1 class="app-page-title mb-0">회원 목록</h1>
                        </div>
                        <div class="col-auto">
                            <div class="page-utilities">
                                <div class="row g-2 justify-content-start justify-content-md-end align-items-center">
                                    <div class="col-auto">
                                        <form @submit.prevent="searchUsers" class="schUser table-search-form row gx-1 align-items-center">
                                            <div class="col-auto">
                                                <select v-model="filters.auth" class="auth-select">
                                                    <option value="">전체[권한]</option>
                                                    <option value="admin">admin</option>
                                                    <option value="manager">manager</option>
                                                    <option value="member">member</option>
                                                    <option value="noauth">noauth</option>
                                                </select>
                                            </div>
                                            <div class="col-auto">
                                                <input type="text" v-model="filters.name" class="form-control search-orders" placeholder="사용자 이름 입력">
                                            </div>
                                            <div class="col-auto">
                                                <input type="text" v-model="filters.nickname" class="form-control search-orders" placeholder="사용자 닉네임 입력">
                                            </div>
                                            <div class="col-auto">
                                                <button type="submit" class="btn app-btn-secondary">검색</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-content" id="orders-table-tab-content">
                        <div class="tab-pane fade show active" id="orders-all" role="tabpanel" aria-labelledby="orders-all-tab">
                            <div class="app-card app-card-orders-table shadow-sm mb-5">
                                <div class="app-card-body">
                                    <table class="table app-table-hover mb-0 text-left">
                                        <thead>
                                            <tr>
                                                <th class="cell">email</th>
                                                <th class="cell">이름</th>
                                                <th class="cell">닉네임</th>
                                                <th class="cell">생일</th>
                                                <th class="cell">권한</th>
                                                <th class="cell">삭제</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="user in users" :key="user.email" :class="user.email">
                                                <td class="cell">{{ user.email }}</td>
                                                <td class="cell">{{ user.name }}</td>
                                                <td class="cell">{{ user.nickname }}</td>
                                                <td class="cell">{{ formatDate(user.birth) }}</td>
                                                <td class="cell">
                                                    <select v-model="user.auth" @change="updateAuth(user)" class="auth-select">
                                                        <option value="admin">admin</option>
                                                        <option value="manager">manager</option>
                                                        <option value="member">member</option>
                                                        <option value="noauth">noauth</option>
                                                    </select>
                                                </td>
                                                <td class="cell"><button @click="deleteUser(user.email)" 
                                                class="btn-sm app-btn-secondary">삭제</button></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="pagination mt-3">
                                        <a href="#" v-for="page in totalPages" :key="page" 
                                        @click.prevent="fetchUsers(page - 1)" class="page-link">{{ page }}</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <footer class="app-footer">
                <div class="container text-center py-3">
                    <small class="copyright">Designed with <span class="sr-only">love</span><i class="fas fa-heart" style="color: #fb866a;"></i> by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
                </div>
            </footer>
        </div>
    </div>

    <!-- Vue.js application script -->
    <script>
        new Vue({
            el: '#memberList',
            data() {
                return {
                    users: [],
                    filters: {
                        auth: '',
                        name: '',
                        nickname: ''
                    },
                    totalPages: 0,
                    pageSize: 10
                };
            },
            methods: {
                fetchUsers(page = 0) {
                    const params = new URLSearchParams({
                        ...this.filters,
                        page,
                        size: this.pageSize
                    }).toString();
                    
                    axios.post('userList', params)
                        .then(response => {
                            this.users = response.data.content;
                            this.totalPages = response.data.totalPages;
                        })
                        .catch(error => {
                            console.error("사용자 목록 요청 실패: ", error);
                        });
                },
                searchUsers() {
                    this.fetchUsers();
                },
                deleteUser(email) {
                    if (confirm('정말 삭제하시겠습니까?')) {
						console.log({email : email})
                        axios.post('delUser', null, { params: { email: email } })
                            .then(response => {
                                this.fetchUsers();
                            })
                            .catch(error => {
                                console.error("사용자 삭제 요청 실패: ", error);
                            });
                    }
                },
                updateAuth(user) {
					axios.post('uptUser', null, { params: 
						{
							email: user.email, auth: user.auth }
						})
				    .then(() => {
				        this.fetchUsers();
				    })
				    .catch(error => {
				        console.error("권한 수정 요청 실패: ", error);
				    });
                },
                formatDate(date) {
                    const d = new Date(date);
                    const month = String(d.getMonth() + 1).padStart(2, '0');
                    const day = String(d.getDate()).padStart(2, '0');
                    const year = d.getFullYear();
                    return year + "년 " + month + "월 " + day + "일";
                }
            },
            mounted() {
                this.fetchUsers();
            }
        });
    </script>
</body>
</html>
