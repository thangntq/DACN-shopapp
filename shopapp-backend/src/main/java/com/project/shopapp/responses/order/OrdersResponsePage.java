package com.project.shopapp.responses.order;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrdersResponsePage {
    private List<OrderResponse> orders;
    private Integer totalPages;
}
