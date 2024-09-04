
        /* 모든 체크박스 요소를 선택 */
        function toggleAll(source) {
            const checkboxes = document.querySelectorAll('.issue-checkbox');
            checkboxes.forEach(checkbox => checkbox.checked = source.checked);
        }
        /* "편집" 또는 "삭제"를 선택 코드*/
        function handleSelectChange(action) {
            const checkboxes = document.querySelectorAll('.issue-checkbox:checked');
            const selectedTkIds = Array.from(checkboxes).map(cb => cb.value);

            if (action === "edit") {
                if (selectedTkIds.length === 1) {
                    const issue = document.querySelector(`.issue-item input[value="${selectedTkIds[0]}"]`);
                    const tkid = issue.value;
                    const name = issue.getAttribute('data-name');
                    const description = issue.getAttribute('data-description');
                    const sid = issue.getAttribute('data-sid');
                    openEditContainer(tkid, name, description, sid);
                } else {
                    alert("편집할 항목을 하나만 선택해 주세요.");
                }
            } else if (action === "delete") {
                deleteSelected(selectedTkIds);
            }
        }
        /* 이 함수는 이슈를 편집할 수 있는 컨테이너를 표시 코드*/
        function openEditContainer(tkid, name, description, sid) {
            document.getElementById('edit-tkid').value = tkid;
            document.getElementById('edit-name').value = name || '';
            document.getElementById('edit-description').value = description || '';
            document.getElementById('edit-sid').value = sid || '';
            document.getElementById('edit-container').style.display = 'block';
        }

        function closeEditContainer() {
            document.getElementById('edit-container').style.display = 'none';
        }

        function openTextarea() {
            document.getElementById('textarea-container').style.display = 'block';
        }

        /* 등록하는 코드 */
        function saveIssue() {
            const issueName = document.getElementById('issue-name').value.trim();
            const startDate = document.getElementById('issue-start-date').value;
            const endDate = document.getElementById('issue-end-date').value;

            if (issueName === '') {
                alert('제목을 입력해 주세요.');
                return;
            }

            $.ajax({
                url: '/taskListInsert',
                type: 'POST',
                data: JSON.stringify({
                    "name": issueName,
                    "description": null, // 기본값 설정
                    "sid": null, // 기본값 설정
                    "endYN": false, // 기본값 설정
                    "start_date": startDate || null, // 날짜 값 설정
                    "end_date": endDate || null // 날짜 값 설정
                }),
                contentType: 'application/json',
                success: function(response) {
                    console.log('성공:', response);
                    location.reload(); // 페이지 새로고침
                },
                error: function(xhr, status, error) {
                    console.error('오류:', error);
                }
            });
        }
        /* 삭제 하는 기능 */
        function deleteSelected(tkids) {
            if (tkids.length === 0) {
                alert('삭제할 항목을 선택해 주세요.');
                return;
            }

            if (confirm('선택한 항목을 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/taskDelete',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ ids: tkids }),
                    success: function (response) {
                        console.log('Response:', response);
                        location.reload(); // 페이지 새로고침
                    },
                    error: function (xhr, status, error) {
                        console.error('Error:', error);
                        alert('삭제 요청 중 오류가 발생했습니다.');
                    }
                });
            }
        }
        /* endYN DB에 바로 적용 하는 코드*/
		function updateStatus(tkid, status) {
		    // status가 '0'이면 false, '1'이면 true로 변환
		    const endYN = status === '1';

		    $.ajax({
		        url: '/updateTaskStatus',
		        type: 'POST',
		        data: JSON.stringify({ tkid: tkid, endYN: endYN }),
		        contentType: 'application/json',
		        success: function(response) {
		            console.log('Status updated:', response);
		        },
		        error: function(xhr, status, error) {
		            console.error('Error updating status:', error);
		        }
		    });
		}
        document.addEventListener('click', function(event) {
            const editContainer = document.getElementById('edit-container');
            if (editContainer.style.display === 'block' && !editContainer.contains(event.target) && !event.target.classList.contains('issue-summary')) {
                closeEditContainer();
            }
        });

        /*엔터키 등록하는 코드*/
        document.addEventListener('keydown', function (event) {
            if (event.key === 'Enter') {
                event.preventDefault();
                saveIssue();
            }
        });

        /* Flatpickr 설정 */
        document.addEventListener('DOMContentLoaded', function() {
            flatpickr("#issue-start-date", {
              dateFormat: "Y-m-d",
            });

            flatpickr("#issue-end-date", {
              dateFormat: "Y-m-d",
            });
        });
        
        // 컨테이너 박스에서 수정 성공하는 코드
        function updateReservation() {
            const tkid = document.getElementById('edit-tkid').value;
            const name = document.getElementById('edit-name').value;
            const description = document.getElementById('edit-description').value;
            const sid = document.getElementById('edit-sid').value;

            if (!tkid || !name) {
                alert('필수 입력 필드를 모두 입력해주세요.');
                return;
            }

            $.ajax({
                url: '/updateTask',
                type: 'POST',
                data: JSON.stringify({
                    tkid: tkid,
                    name: name,
                    description: description,
                    sid: sid
                }),
                contentType: 'application/json',
                success: function(response) {
                    alert('업데이트 성공');
                    location.reload(); // 페이지 새로고침
                },
                error: function(xhr, status, error) {
                    console.error('Error updating task:', error);
                    alert('업데이트 중 오류가 발생했습니다.');
                }
            });
        }
       
        // 저장 옆에 닫기 버튼 
        function closeTextarea() {
            document.getElementById('textarea-container').style.display = 'none';
        }
        
     // 모달 열기 함수
        function openModal() {
            document.getElementById('title-modal').style.display = 'block';
        }

        // 모달 닫기 함수
        function closeModal() {
            document.getElementById('title-modal').style.display = 'none';
        }

        // 제목 업데이트 함수
        function updateTitle() {
            const newTitle = document.getElementById('title-input').value.trim();
            if (newTitle === '') {
                alert('제목을 입력해 주세요.');
                return;
            }

            // 제목을 업데이트 (여기서는 클라이언트 사이드에서 처리)
            document.getElementById('sprint-title').textContent = newTitle;
            closeModal(); // 모달 닫기
        }